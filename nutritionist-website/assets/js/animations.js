document.addEventListener('DOMContentLoaded', () => {
    // Check if GSAP is available
    if (typeof gsap !== 'undefined') {
        gsap.registerPlugin(ScrollTrigger);

        // 1. Hero Content Reveal
        gsap.from('.hero-content > *', {
            y: 40,
            opacity: 0,
            duration: 1,
            stagger: 0.2,
            ease: 'power3.out'
        });

        // 2. Generic Scroll Reveal
        const reveals = document.querySelectorAll('.reveal');
        
        reveals.forEach((el) => {
            gsap.to(el, {
                scrollTrigger: {
                    trigger: el,
                    start: 'top 85%',
                    toggleActions: 'play none none none'
                },
                y: 0,
                opacity: 1,
                duration: 1.2,
                ease: 'power3.out'
            });
        });

        // 3. Staggered Card Animation
        const cardContainers = document.querySelectorAll('.row');
        cardContainers.forEach(container => {
            const cards = container.querySelectorAll('.card');
            if (cards.length > 0) {
              gsap.to(cards, {
                  scrollTrigger: {
                      trigger: container,
                      start: 'top 80%',
                  },
                  y: 0,
                  opacity: 1,
                  duration: 0.8,
                  stagger: 0.15,
                  ease: 'power2.out'
              });
            }
        });

        // 4. Smooth Navigation Fade
        gsap.from('.navbar', {
            opacity: 0,
            duration: 1.2,
            delay: 0.5,
            ease: 'power2.out'
        });
    } else {
        console.warn('GSAP not loaded. Animation script skipped.');
        // Fallback: static visibility
        document.querySelectorAll('.reveal').forEach(el => el.style.opacity = '1');
    }
});
