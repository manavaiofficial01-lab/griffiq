const fs = require('fs');
const path = require('path');

const badgeRemoverBlock = `<style id="__framer-badge-hide-style">
#__framer-badge-container,
.__framer-badge,
[id*="framer-badge"],
[class*="__framer-badge"],
[class*="framer-badge"],
a[href*="framer.com"],
div[data-framer-name*="Badge"],
#__framer-badge-container * {
    display: none !important;
    opacity: 0 !important;
    visibility: hidden !important;
    pointer-events: none !important;
    width: 0 !important;
    height: 0 !important;
    max-width: 0 !important;
    max-height: 0 !important;
    overflow: hidden !important;
    position: absolute !important;
    top: -9999px !important;
    left: -9999px !important;
    z-index: -999999 !important;
}
</style>
<script id="__framer-badge-remover">
(function() {
  var origGetId = document.getElementById.bind(document);
  document.getElementById = function(id) {
    if (id === '__framer-badge-container') {
      var el = origGetId(id);
      if (el) el.remove();
      return null;
    }
    return origGetId(id);
  };
  function killBadge() {
    var badge = origGetId('__framer-badge-container');
    if (badge) badge.remove();
    var badges = document.querySelectorAll('.__framer-badge, [id*="framer-badge"], [class*="__framer-badge"]');
    badges.forEach(function(b) { b.remove(); });
  }
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', killBadge);
  } else {
    killBadge();
  }
  window.addEventListener('load', killBadge);
  if (window.MutationObserver) {
    var obs = new MutationObserver(function(mutations) {
      killBadge();
    });
    if (document.documentElement) {
      obs.observe(document.documentElement, { childList: true, subtree: true });
    }
  }
})();
</script>`;

function processDir(dir) {
  const entries = fs.readdirSync(dir);
  for (const entry of entries) {
    const fullPath = path.join(dir, entry);
    const stat = fs.statSync(fullPath);

    if (stat.isDirectory()) {
      if (entry !== '.git' && entry !== 'node_modules') {
        processDir(fullPath);
      }
    } else if (entry.endsWith('.html')) {
      let content = fs.readFileSync(fullPath, 'utf8');

      // Remove previous injected styles
      content = content.replace(/<style>#__framer-badge-container[\s\S]*?<\/style>/gi, '');
      content = content.replace(/<style id="__framer-badge-hide-style">[\s\S]*?<\/script>/gi, '');
      content = content.replace(/<div id="__framer-badge-container">[\s\S]*?<\/div>/gi, '');

      if (!content.includes('__framer-badge-hide-style')) {
        if (content.includes('</head>')) {
          content = content.replace('</head>', badgeRemoverBlock + '\n</head>');
        } else if (content.includes('<body')) {
          content = content.replace('<body', badgeRemoverBlock + '\n<body');
        }
      }

      fs.writeFileSync(fullPath, content, 'utf8');
      console.log('Cleaned:', fullPath);
    }
  }
}

processDir('.');
console.log('Finished removing Framer badge from all HTML files.');

