document.addEventListener('DOMContentLoaded', () => {
    // 1. Theme Toggle Logic
    const themeToggles = document.querySelectorAll('#theme-toggle, #theme-toggle-mobile');
    const body = document.documentElement;
    const currentTheme = localStorage.getItem('theme') || 'light';

    // Initialize Theme
    body.setAttribute('data-theme', currentTheme);
    themeToggles.forEach(toggle => updateThemeIcon(toggle, currentTheme));

    themeToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const targetTheme = body.getAttribute('data-theme') === 'light' ? 'dark' : 'light';
            body.setAttribute('data-theme', targetTheme);
            localStorage.setItem('theme', targetTheme);
            themeToggles.forEach(t => updateThemeIcon(t, targetTheme));
        });
    });

    function updateThemeIcon(toggle, theme) {
        if (!toggle) return;
        const icon = toggle.querySelector('i');
        icon.className = theme === 'dark' ? 'fas fa-sun' : 'fas fa-moon';
    }

    // 1.5 RTL Toggle Logic
    const rtlToggles = document.querySelectorAll('#rtl-toggle, #rtl-toggle-mobile');
    const currentDir = localStorage.getItem('dir') || 'ltr';
    body.setAttribute('dir', currentDir);
    
    function updateRtlIcon(toggle, dir) {
        if (!toggle) return;
        const icon = toggle.querySelector('i');
        icon.className = (dir === 'rtl') ? 'fas fa-align-left' : 'fas fa-align-right';
    }
    rtlToggles.forEach(t => updateRtlIcon(t, currentDir));

    rtlToggles.forEach(toggle => {
        toggle.addEventListener('click', () => {
            const targetDir = body.getAttribute('dir') === 'ltr' ? 'rtl' : 'ltr';
            body.setAttribute('dir', targetDir);
            localStorage.setItem('dir', targetDir);
            rtlToggles.forEach(t => updateRtlIcon(t, targetDir));
        });
    });

    // 2. Navbar Scroll Effect
    const navbar = document.querySelector('.navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 50) {
            navbar.classList.add('scrolled');
        } else {
            navbar.classList.remove('scrolled');
        }
    });

    // 3. Smooth Anchor Links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            if (this.getAttribute('href') === '#') return;
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth',
                    block: 'start'
                });
            }
        });
    });

    // 4. Mobile Menu Logic
    const navToggle = document.querySelector('.mobile-nav-toggle');
    const navMenu = document.querySelector('.nav-menu');

    if (navToggle && navMenu) {
        navToggle.addEventListener('click', () => {
            navMenu.classList.toggle('active');
            navToggle.querySelector('i').classList.toggle('fa-bars');
            navToggle.querySelector('i').classList.toggle('fa-times');
        });

        // Close menu when clicking links (excluding dropdown toggles)
        navMenu.querySelectorAll('a').forEach(link => {
            link.addEventListener('click', (e) => {
                // On mobile, if a link has a dropdown sibling, let the browser handle dropdown toggle only
                if (window.innerWidth < 992 && link.nextElementSibling?.classList.contains('dropdown-menu')) {
                    e.preventDefault();
                    return; 
                }
                navMenu.classList.remove('active');
                navToggle.querySelector('i').classList.add('fa-bars');
                navToggle.querySelector('i').classList.remove('fa-times');
            });
        });
    }
});
