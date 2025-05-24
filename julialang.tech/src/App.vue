<template>
  <div class="app">
    <!-- Header / Navigation -->
    <header class="header">
      <h6 class="public-said">①服务内测中...🇨🇳</h6>
      <div class="container header-content">
        <h1 class="logo">
          <img src="/icon.jpeg" width="48" height="48"/>
          <span>JULIA</span>
        </h1>

        <!-- Desktop Nav -->
        <nav class="desktop-nav">
          <a href="#services">服务</a>
          <a href="#features">优势</a>
          <a href="#pricing">价格</a>
          <a href="#contact">联系</a>
        </nav>

        <!-- Auth Buttons -->
        <div class="auth-buttons">
          <a href="#" class="login-btn" @click="showLoginModal = true">登录</a>
          <a href="#" class="register-btn" @click="showRegisterModal = true">注册</a>
        </div>

        <!-- Mobile Menu Toggle -->
        <button @click="toggleMenu" class="menu-toggle">&#9776;</button>
      </div>

      <!-- Mobile Menu -->
      <transition name="slide">
        <div v-show="isMobileMenuOpen" class="mobile-menu">
          <a href="#services" @click="toggleMenu">服务</a>
          <a href="#features" @click="toggleMenu">优势</a>
          <a href="#pricing" @click="toggleMenu">价格</a>
          <a href="#contact" @click="toggleMenu">联系</a>
          <a href="#" @click="showLoginModal = true">登录</a>
          <a href="#" @click="showRegisterModal = true">注册</a>
        </div>
      </transition>
    </header>

    <!-- Hero Section -->
    <section class="hero">
      <div class="container text-center">
        <h2>开发者网络服务平台</h2>
        <p class="tagline">提供稳定、安全的隧道和中转服务</p>
        <p class="description">Nexus & Ngrok 已上线，更多服务即将推出。</p>
        <div class="cta-buttons">
          <a href="#services" class="btn primary">查看服务</a>
          <a href="#docs" class="btn secondary">文档中心</a>
        </div>
      </div>
    </section>

    <!-- Services Section -->
    <section id="services" class="services-section">
      <div class="container">
        <h2 class="section-title">我们的服务</h2>
        <p class="section-subtitle">当前可用与即将上线的网络服务</p>

        <h3 class="service-category">已上线服务</h3>
        <div class="services-grid">
          <div v-for="(service, index) in liveServices" :key="index" class="service-card">
            <h4>{{ service.name }}</h4>
            <p>{{ service.description }}</p>
            <ul>
              <li v-for="(feature, i) in service.features" :key="i">
                <span class="icon-check"></span> {{ feature }}
              </li>
            </ul>
            <span class="badge live">已上线</span>
          </div>
        </div>

        <h3 class="service-category">即将上线服务</h3>
        <div class="services-grid">
          <div v-for="(service, index) in upcomingServices" :key="index" class="service-card upcoming">
            <h4>{{ service.name }}</h4>
            <p>{{ service.description }}</p>
            <ul>
              <li v-for="(feature, i) in service.features" :key="i">
                <span class="icon-warning"></span> {{ feature }}
              </li>
            </ul>
            <span class="badge upcoming">即将上线</span>
          </div>
        </div>
      </div>
    </section>

    <!-- Features Section -->
    <section id="features" class="features-section">
      <div class="container">
        <h2 class="section-title">为什么选择我们？</h2>
        <p class="section-subtitle">稳定、安全、易用，面向开发者的专业网络服务</p>

        <div class="features-grid">
          <div class="feature-box">
            <div class="feature-icon security"></div>
            <h4>企业级安全</h4>
            <p>所有服务均采用加密传输协议，支持身份验证和访问控制，保障您的数据安全。</p>
          </div>
          <div class="feature-box">
            <div class="feature-icon performance"></div>
            <h4>高性能架构</h4>
            <p>分布式节点部署，智能负载均衡，确保低延迟和高可用性。</p>
          </div>
          <div class="feature-box">
            <div class="feature-icon developer"></div>
            <h4>开发者友好</h4>
            <p>提供详细的 API 文档、SDK 和 CLI 工具，快速集成到你的开发流程。</p>
          </div>
        </div>
      </div>
    </section>
    <!-- Pricing Section -->
    <section id="pricing" class="pricing-section">
      <div class="section-title">
        <h2 class="section-title">价格计划</h2>
        <p class="section-subtitle">简单透明的定价策略</p>

        <div class="pricing-cards">
          <div class="pricing-card free">
            <h3>免费试用</h3>
            <p class="price"><span class="unit">¥</span>0<span class="duration">/周</span></p>
            <ul>
              <li><span class="icon-check"></span> 7 天免费体验</li>
              <li><span class="icon-check"></span> 基础功能开放</li>
              <li><span class="icon-check"></span> 无限制使用</li>
            </ul>
            <button class="btn primary">立即体验</button>
          </div>
          <div class="pricing-card premium">
            <h3>年度会员</h3>
            <p class="price"><span class="unit">¥</span>99<span class="duration">/年</span></p>
            <ul>
              <li><span class="icon-check"></span> 全部功能解锁</li>
              <li><span class="icon-check"></span> 高速带宽优先</li>
              <li><span class="icon-check"></span> 技术支持服务</li>
            </ul>
            <button class="btn primary">立即开通</button>
          </div>
        </div>
      </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-full">
      <div class="container text-center">
        <h2>开始使用我们的服务</h2>
        <p>立即注册获取免费试用额度，体验稳定高效的网络服务。</p>
        <a href="#" class="btn cta-btn">立即注册</a>
      </div>
    </section>

    <!-- Contact Section -->
    <section id="contact" class="contact-section">
      <div class="container text-center">
        <h2>联系客服</h2>
        <p class="section-subtitle">扫码关注公众号获取帮助</p>
        <div class="qrcode">
          <img src="/public_acount.png" alt="公众号二维码" width="412" height="138">
        </div>
        <p class="wechat-name">公众号：旷野说</p>
      </div>
    </section>

    <!-- Footer -->
    <footer id="contact" class="footer">
      <div class="container">
        <div class="footer-grid">
          <div class="footer-about">
            <h3>关于 JULIA</h3>
            <p>JULIA 致力于为开发者提供稳定、安全、高效的网络服务，帮助您快速构建和部署应用。</p>
            <p>&copy; 2025 JULIA. All rights reserved.</p>
          </div>
          <div>
            <h3>服务</h3>
            <ul>
              <li><a href="#">Nexus</a></li>
              <li><a href="#">Ngrok</a></li>
              <li><a href="#">Redis</a></li>
              <li><a href="#">MQTT</a></li>
            </ul>
          </div>
          <div>
            <h3>资源</h3>
            <ul>
              <li><a href="#">文档</a></li>
              <li><a href="#">API 参考</a></li>
              <li><a href="#">博客</a></li>
              <li><a href="#">支持</a></li>
            </ul>
          </div>
        </div>
        <div class="footer-bottom">
          <p>隐私政策 | 使用条款 | 帮助中心</p>
        </div>
      </div>
    </footer>
    <!-- Login Modal -->
    <div v-if="showLoginModal" class="modal-overlay" @click.self="showLoginModal = false">
      <div class="modal">
        <h3>用户登录</h3>
        <form @submit.prevent="handleLogin">
          <input type="email" placeholder="邮箱" required />
          <input type="password" placeholder="密码" required />
          <button type="submit" class="btn primary full-width">登录</button>
          <p class="switch-link">还没有账号？<a href="#" @click="showLoginModal = false; showRegisterModal = true">去注册</a></p>
        </form>
      </div>
    </div>
    <!-- Register Modal -->
    <div v-if="showRegisterModal" class="modal-overlay" @click.self="showRegisterModal = false">
      <div class="modal">
        <h3>用户注册</h3>
        <form @submit.prevent="handleRegister">
          <input type="text" placeholder="用户名" required />
          <input type="email" placeholder="邮箱" required />
          <input type="password" placeholder="密码" required />
          <button type="submit" class="btn primary full-width">注册</button>
          <p class="switch-link">已有账号？<a href="#" @click="showRegisterModal = false; showLoginModal = true">去登录</a></p>
        </form>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref } from 'vue';

const isMobileMenuOpen = ref(false);
const showLoginModal = ref(false);
const showRegisterModal = ref(false);

const toggleMenu = () => {
  isMobileMenuOpen.value = !isMobileMenuOpen.value;
};

const handleLogin = () => {
  alert('登录成功');
  showLoginModal.value = false;
};

const handleRegister = () => {
  alert('注册成功');
  showRegisterModal.value = false;
};

const liveServices = [
  {
    name: "Nexus",
    description: "连接本地服务器到互联网，支持自定义域名和认证功能。",
    features: ["自定义域名", "基础认证", "Web 控制台", "HTTPS 支持"]
  },
  {
    name: "Ngrok",
    description: "一键生成公网 HTTPS 地址，可查看请求流量并支持 Webhook 测试。",
    features: ["HTTPS 公网地址", "请求查看", "认证支持", "Webhook 测试"]
  }
];

const upcomingServices = [
  {
    name: "Redis",
    description: "高性能内存数据库托管服务，适用于缓存和实时数据处理。",
    features: ["持久化存储", "自动扩展", "监控系统", "安全机制"]
  },
  {
    name: "MQTT",
    description: "轻量级物联网通信协议，支持消息代理管理和 QoS 控制。",
    features: ["消息代理托管", "主题管理", "TLS 加密", "QoS 支持"]
  },
  {
    name: "TunServer",
    description: "基于 TCP/UDP 的虚拟私有网络服务，提供加密远程访问。",
    features: ["加密隧道", "跨平台支持", "端口转发", "访问控制"]
  },
  {
    name: "WireGuard",
    description: "现代、高速、安全的 VPN 服务，配置简单且性能优化。",
    features: ["高速连接", "简化配置", "默认安全", "跨平台"]
  }
];
</script>

<style scoped>
/* Reset */
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
}
body {
  font-family: 'Segoe UI', sans-serif;
  background-color: #f9fafb;
  color: #333;
}

/* Container */
.container {
  width: 100%;
  max-width: 1200px;
  margin: auto;
  padding: 0 20px;
}

/* Text Center Utility */
.text-center {
  text-align: center;
}

/* Utilities */
.btn {
  display: inline-block;
  padding: 12px 24px;
  text-decoration: none;
  border-radius: 4px;
  font-weight: bold;
  transition: all 0.3s ease;
}
.btn.primary {
  background-color: #4f46e5;
  color: white;
  border: none;
}
.btn.secondary {
  background-color: transparent;
  color: #4f46e5;
  border: 2px solid #4f46e5;
}
.btn:hover {
  opacity: 0.9;
}

/* Header */
.header {
  background-color: white;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
  position: sticky;
  top: 0;
  z-index: 1000;
}
.header-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  height: 64px;
  flex-wrap: wrap;
}
.logo {
  font-size: 1.5rem;
  color: #4f46e5;
  font-weight: bold;
  display: flex;
  align-items: center;

}
.desktop-nav {
  display: flex;
  gap: 20px;
}
.desktop-nav a {
  text-decoration: none;
  color: #333;
  font-weight: 500;
}
.auth-buttons {
  display: flex;
  gap: 10px;
}
.login-btn,
.register-btn {
  text-decoration: none;
  font-weight: 500;
  padding-top: 6px;
  color: #0079ff;
  font-size: x-large;
}
.register-btn {
  background-color: #4f46e5;
  color: white;
  padding: 8px 16px;
  border-radius: 4px;
}
.menu-toggle {
  display: none;
  background: none;
  border: none;
  font-size: 1.5rem;
  cursor: pointer;
}

/* Mobile Menu */
.mobile-menu {
  background-color: white;
  padding: 10px 20px;
  border-top: 1px solid #eee;
}
.mobile-menu a {
  display: block;
  padding: 10px 0;
  text-decoration: none;
  color: #333;
}
.slide-enter-active,
.slide-leave-active {
  transition: max-height 0.3s ease-out;
  overflow: hidden;
}
.slide-enter-from,
.slide-leave-to {
  max-height: 0;
}

/* Hero */
.hero {
  background: linear-gradient(to right bottom, #e0e7ff, #f3f4f6);
  padding: 60px 20px;
}
.hero h2 {
  font-size: 2rem;
  color: #111827;
}
.hero .tagline {
  font-size: 1.25rem;
  color: #4f46e5;
  margin: 10px 0;
}
.hero .description {
  font-size: 1.1rem;
  color: #6b7280;
  margin: 20px 0;
}
.cta-buttons {
  margin-top: 20px;
  display: flex;
  justify-content: center;
  flex-wrap: wrap;
  gap: 15px;
}

/* Services */
.services-section {
  padding: 60px 20px;
}
.section-title {
  font-size: 2rem;
  color: #111827;
  margin-bottom: 10px;
}
.section-subtitle {
  font-size: 1.1rem;
  color: #6b7280;
  margin-bottom: 40px;
}
.service-category {
  font-size: 1.5rem;
  margin-bottom: 20px;
  color: #111827;
}
.services-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 20px;
}
.service-card {
  background: white;
  padding: 20px;
  border-left: 4px solid #10b981;
  border-radius: 6px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  position: relative;
}
.service-card.upcoming {
  border-left-color: #fbbf24;
}
.service-card ul {
  list-style: none;
  padding-left: 0;
}
.service-card li {
  margin: 8px 0;
}
.icon-check::before {
  content: '✓';
  color: #10b981;
  margin-right: 5px;
}
.icon-warning::before {
  content: '⚠️';
  margin-right: 5px;
}
.badge {
  position: absolute;
  top: 20px;
  right: 20px;
  padding: 4px 10px;
  border-radius: 4px;
  font-size: 0.8rem;
}
.badge.live {
  background-color: #dcfce7;
  color: #16a34a;
}
.badge.upcoming {
  background-color: #fef9c3;
  color: #d97706;
}

/* Features */
.features-section {
  background-color: #f3f4f6;
  padding: 60px 20px;
}
.features-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}
.feature-box {
  background: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  text-align: center;
}
.feature-icon {
  width: 60px;
  height: 60px;
  margin: 0 auto 15px;
  border-radius: 50%;
  background-size: cover;
}
.security {
  background-image: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="%234f46e5"%3E%3Cpath strokeLinecap="round" strokeLinejoin="round" strokeWidth="{2}" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"%3E%3C/path%3E%3C/svg%3E');
}
.performance {
  background-image: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="%234f46e5"%3E%3Cpath strokeLinecap="round" strokeLinejoin="round" strokeWidth="{2}" d="M13 10V3L4 14h7v7l9-11h-7z"%3E%3C/path%3E%3C/svg%3E');
}
.developer {
  background-image: url('data:image/svg+xml,%3Csvg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke="%234f46e5"%3E%3Cpath strokeLinecap="round" strokeLinejoin="round" strokeWidth="{2}" d="M10 20l4-16m4 4l4 4-4 4M6 16l-4-4 4-4"%3E%3C/path%3E%3C/svg%3E');
}
.feature-box h4 {
  font-size: 1.2rem;
  margin-bottom: 10px;
}

/* CTA Full */
.cta-full {
  background-color: #4338ca;
  color: white;
  padding: 60px 20px;
}
.cta-full h2 {
  font-size: 2rem;
  margin-bottom: 15px;
}
.cta-full p {
  font-size: 1.1rem;
  margin-bottom: 20px;
}
.cta-btn {
  background-color: white;
  color: #4338ca;
  border: none;
}

/* Footer */
.footer h3 {
  font-size: x-large;
  color: #232ea3;
}
.footer {
  background-color: white;
  padding: 40px 20px;
  border-top: 1px solid #e5e7eb;
}
.footer-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  gap: 30px;
}
.footer-about h3 {
  margin-bottom: 15px;
}
.footer ul {
  list-style: none;
}
.footer ul li {
  margin: 8px 0;
}
.footer ul li a {
  text-decoration: none;
  color: #333;
}
.footer-bottom {
  margin-top: 30px;
  text-align: center;
  color: #9ca3af;
  font-size: 0.9rem;
}

/* Responsive */
@media (max-width: 768px) {
  .desktop-nav {
    display: none;
  }
  .menu-toggle {
    display: block;
  }
  .hero h2 {
    font-size: 1.5rem;
  }
  .hero .tagline,
  .hero .description {
    font-size: 1rem;
  }
  .feature-box {
    margin-bottom: 20px;
  }
}

.price {
  font-size: 2.5rem;
  font-weight: bold;
  margin-bottom: 20px;
}

.pricing-cards {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
  gap: 30px;
}
.pricing-card {
  background: white;
  padding: 30px 20px;
  border-radius: 10px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.05);
  text-align: center;
}
.pricing-card h3 {
  font-size: x-large;
  margin-bottom: 20px;
}

.pricing-card ul {
  list-style: none;
  padding-left: 0;
  margin-bottom: 20px;
}
.pricing-card li {
  margin: 10px 0;
}

.public-said {
  text-align: left;
  background: #4338ca;
  color:#dcfce7;
  padding: 12px 24px;
}
/* Modals */
.modal-overlay {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 999;
}
.modal {
  background: white;
  padding: 30px;
  border-radius: 10px;
  width: 90%;
  max-width: 400px;
}
.modal h3 {
  text-align: center;
  margin-bottom: 20px;
}
.modal input {
  width: 100%;
  padding: 10px;
  margin-bottom: 15px;
  border: 1px solid #ccc;
  border-radius: 4px;
}
.switch-link {
  margin-top: 15px;
  text-align: center;
  font-size: 0.9rem;
}
.switch-link a {
  color: #4f46e5;
  text-decoration: underline;
}


/* Dark Mode Styles */
@media (prefers-color-scheme: dark) {

  body {
    color: #e5e7eb;
    background-color: #b2c5f1;
    background: #e6c8a5;
  }

  .section-title {
    font-size: 2rem;
    color: #232ea3;
    margin-bottom: 10px;
    font-weight:bold;
  }
  /* Services */
  .services-section {
    padding: 60px 20px;
    background: #b6c5e1;
    color: #e5e7eb;
  }

  .header,
  .hero,
  .pricing-section,
  .contact-section,
  .cta-full,
  .footer {
    background-color: #1f2937;
    color: #e5e7eb;
  }

  .desktop-nav a {
    color: #d1d5db;
  }

  .service-card,
  .feature-box,
  .modal {
    background: #374151;
    color: #e5e7eb;
  }

  .logo {
    color: #a5b4fc;
  }

  .btn.primary {
    background-color: #818cf8;
    color: white;
  }

  .btn.secondary {
    color: #818cf8;
    border-color: #818cf8;
  }

  input,
  textarea {
    background-color: #1f2937;
    color: white;
    border-color: #4b5563;
  }

  .footer ul li a {
    text-decoration: none;
    color: #e5e7eb;
    border-color: #4b5563;
  }
}


</style>