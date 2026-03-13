(function() {
    var scripts = document.getElementsByTagName('script');
    var thisScript = scripts[scripts.length - 1];
    var prefix = thisScript.getAttribute('src').replace('sidebar.js', '');

    var html =
        '<div class="sidebar-header">Site Index:</div>' +
        '<ul class="nav-tree">' +
        '<li><a href="{{P}}index.html">What\'s New?</a></li>' +
        '<li><details open><summary>Programming</summary>' +
        '<ul>' +
        '<li><a href="{{P}}programming.html">Introduction</a></li>' +
        '<li><details><summary>6502</summary>' +
        '<ul>' +
        '<li><a href="{{P}}6502/index.html">Introduction</a></li>' +
        '<li><a href="{{P}}6502/architecture.html">Architecture</a></li>' +
        '<li><a href="{{P}}6502/registers.html">Registers</a></li>' +
        '<li><a href="{{P}}6502/instructions.html">Instructions</a></li>' +
        '<li><a href="{{P}}6502/addressing.html">Addressing</a></li>' +
        '<li><a href="{{P}}6502/algorithms.html">Algorithms</a></li>' +
        '<li><a href="{{P}}6502/reference.html">Reference</a></li>' +
        '<li><a href="{{P}}6502/downloads.html">Downloads</a></li>' +
        '<li><a href="{{P}}6502/links.html">Links</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>65C02</summary>' +
        '<ul>' +
        '<li><a href="{{P}}65c02/index.html">Introduction</a></li>' +
        '<li><a href="{{P}}65c02/addressing.html">Addressing</a></li>' +
        '<li><a href="{{P}}65c02/reference.html">Reference</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>Dev65</summary>' +
        '<ul>' +
        '<li><a href="{{P}}dev65/index.html">Introduction</a></li>' +
        '<li><a href="{{P}}dev65/as65.html">As65</a></li>' +
        '<li><a href="{{P}}dev65/lk65.html">Lk65</a></li>' +
        '<li><a href="{{P}}dev65/lb65.html">Lb65</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>CESIL</summary>' +
        '<ul>' +
        '<li><a href="{{P}}cesil/index.html">Introduction</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>VHDL</summary>' +
        '<ul>' +
        '<li><a href="{{P}}vhdl/index.html">Introduction</a></li>' +
        '<li><a href="{{P}}vhdl/cmos.html">CMOS Logic</a></li>' +
        '<li><a href="{{P}}vhdl/74series.html">74 Series Logic</a></li>' +
        '<li><a href="{{P}}vhdl/links.html">Links</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>Microchip PIC</summary>' +
        '<ul>' +
        '<li><a href="{{P}}pic/addsub.html">Multi-byte Add/Sub</a></li>' +
        '<li><a href="{{P}}pic/incdec.html">Multi-byte Inc/Dec</a></li>' +
        '</ul>' +
        '</details></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details open><summary>Electronics</summary>' +
        '<ul>' +
        '<li><a href="{{P}}electronics/index.html">Introduction</a></li>' +
        '<li><details><summary>Projects</summary>' +
        '<ul>' +
        '<li><a href="{{P}}electronics/dice.html">Electronic Dice</a></li>' +
        '<li><a href="{{P}}electronics/alarm.html">Alarm Clock</a></li>' +
        '<li><a href="{{P}}electronics/metronome.html">Metronome</a></li>' +
        '<li><a href="{{P}}electronics/clock.html">Binary Clock</a></li>' +
        '<li><a href="{{P}}electronics/r6501.html">R6501 SBC</a></li>' +
        '<li><a href="{{P}}electronics/em-65c02.html">EM-65C02</a></li>' +
        '<li><a href="{{P}}electronics/sb-6502.html">SB-65C02</a></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>Prototypes</summary>' +
        '<ul>' +
        '<li><a href="{{P}}electronics/miranda.html">Chess Computer</a></li>' +
        '<li><a href="{{P}}electronics/old-skool.html">BASIC Computer</a></li>' +
        '</ul>' +
        '</details></li>' +
        '</ul>' +
        '</details></li>' +
        '<li><details><summary>About...</summary>' +
        '<ul>' +
        '<li><a href="{{P}}about.html">About this site</a></li>' +
        '<li><a href="{{P}}privacy.html">Privacy</a></li>' +
        '</ul>' +
        '</details></li>' +
        '</ul>' +
        '<div class="sidebar-footer">Copyright \u00A91999-2018<br>' +
        '<a style="color: #555; text-decoration: none;" href="http://forum.6502.org/viewtopic.php?t=6466">Andrew John Jacobs</a></div>';

    html = html.split('{{P}}').join(prefix);

    var sidebar = document.getElementById('sidebar');
    sidebar.innerHTML = html;

    // Highlight current page and expand ancestor folders
    var currentPath = window.location.pathname;
    var links = sidebar.getElementsByTagName('a');
    for (var i = 0; i < links.length; i++) {
        var a = links[i];
        if (a.pathname === currentPath ||
            a.pathname === currentPath.replace(/\/$/, '/index.html')) {
            a.className = 'current';
            var el = a.parentNode;
            while (el && el !== sidebar) {
                if (el.tagName === 'DETAILS') {
                    el.setAttribute('open', '');
                }
                el = el.parentNode;
            }
            break;
        }
    }

    // Mobile menu toggle
    var wrapper = sidebar.parentNode;

    var toggle = document.createElement('button');
    toggle.className = 'menu-toggle';
    toggle.textContent = '\u2630 Menu';
    wrapper.parentNode.insertBefore(toggle, wrapper);

    var overlay = document.createElement('div');
    overlay.className = 'sidebar-overlay';
    wrapper.parentNode.insertBefore(overlay, wrapper);

    function openMenu() {
        sidebar.classList.add('open');
        overlay.classList.add('open');
    }
    function closeMenu() {
        sidebar.classList.remove('open');
        overlay.classList.remove('open');
    }

    toggle.addEventListener('click', function() {
        if (sidebar.classList.contains('open')) {
            closeMenu();
        } else {
            openMenu();
        }
    });
    overlay.addEventListener('click', closeMenu);
})();
