#!/bin/zsh

# 安全终止所有用户级 Java 进程脚本 (M1 Optimized)
# 避免终止系统关键进程：Rosetta、WindowServer、系统守护进程等

# 检测当前用户权限
if [[ $EUID -eq 0 ]]; then
    echo "⚠️ 警告：请勿使用 root 权限执行此脚本"
    echo "建议执行：sudo -u $(logname) $0"
    exit 1
fi

# 获取当前登录用户
current_user=$(logname)

# 查找所有 Java 进程（排除系统关键进程）
pids=($(ps axo pid,user,comm,args |
    grep -Ew 'java|javaw|jdk|jre' |
    grep -vE 'Rosetta|WindowServer|VDCAssistant|coreauthd|UserEventAgent' |
    grep "$current_user" |
    awk '{print $1}'))

if [[ ${#pids[@]} -eq 0 ]]; then
    echo "✅ 未找到属于用户 $current_user 的 Java 进程"
    exit 0
fi

echo "即将终止以下 Java 进程："
ps -p ${(j:,:)pids} -o pid,user,command

# 确认提示
read -rq "?是否继续？(y/N) "
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "操作已取消"
    exit 0
fi

# 优雅终止进程
for pid in $pids; do
    echo "🛑 终止进程 $pid ($(ps -p $pid -o comm=))"
    kill -TERM $pid >/dev/null 2>&1

    # 等待 3 秒后强制终止
    sleep 3
    if ps -p $pid >/dev/null; then
        echo "⛔ 强制终止 $pid"
        kill -KILL $pid >/dev/null 2>&1
    fi
done

echo "✅ 所有 Java 进程已终止"
echo "残留进程检查："
pgrep -ilf 'java|jdk|jre'

