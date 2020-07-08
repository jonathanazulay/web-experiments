window.addEventListener("click", function(event) { 
    if(event.target.tagName === 'A') {
        event.preventDefault();
        console.log(event.target.href);
        const portal = document.createElement('portal');
        portal.src = event.target.href;
        portal.addEventListener('load', () => {
            console.log('Portal loaded');
            portal.classList.add('portal--animate')
            portal.addEventListener('animationend', function () {
                portal.activate();
            });
        });
        document.body.appendChild(portal);
        
    }
 });