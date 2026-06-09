$sourcePath = 'd:\Project\SAM - P\ambiguous-posterity-545330.framer.app\skills.html'
$targetPath = 'd:\Project\SAM - P\recreate framer into griffiq\skills.html'

$customBlock = @'

	<style>
		/* Hide Framer watermark badge completely */
		#__framer-badge-container,
		.__framer-badge,
		.framer-badge,
		[id*="badge-container"],
		a[href*="framer.com"] {
			display: none !important;
			visibility: hidden !important;
			opacity: 0 !important;
			pointer-events: none !important;
		}
		/* Fix duplicate scroll down tag: hide any extra instance after the first */
		.framer-sr7n9t ~ .framer-sr7n9t {
			display: none !important;
		}
	</style>
	<script>
		// Remove duplicate scroll down tags injected by Framer JS hydration
		(function() {
			function removeDuplicateScrollDown() {
				var tags = document.querySelectorAll('.framer-sr7n9t');
				if (tags.length > 1) {
					for (var i = 1; i < tags.length; i++) {
						tags[i].style.display = 'none';
					}
				}
			}
			// Run immediately and after page load
			removeDuplicateScrollDown();
			window.addEventListener('load', removeDuplicateScrollDown);
			// Also watch for DOM changes (Framer hydration)
			var observer = new MutationObserver(removeDuplicateScrollDown);
			observer.observe(document.body, { childList: true, subtree: true });
		})();
	</script>
	<script>
		(function() {
			var isSubFolder = window.location.pathname.indexOf('/work/') !== -1 || window.location.href.indexOf('/work/') !== -1;
			var basePath = isSubFolder ? '../images/' : 'images/';
			
			var originalLogoKeys = [
				'8hCYc56tNZzqrKqV7qVWAqrYMxc',
				'tFya15qWif6s1zSmaYjTP24BaAE',
				'r6bP2iqHkzVFRl1CXiAMowtRg',
				'TUk37nolbXzghpHGYw5vKHWJqA'
			];

			var logoFiles = [
				'sap_logo.png',
				'geekneo_logo.png',
				'kalyani_logo.png',
				'dmakers_logo.png',
				'Artboard 3@4x.png',
				'Artboard 5@4x.png',
				'Artboard 7@4x.png'
			];

			function replaceImages() {
				var imgs = Array.prototype.slice.call(document.querySelectorAll('img'));
				var marqueeImgs = imgs.filter(function(img) {
					var src = img.getAttribute('src') || '';
					var isCustom = logoFiles.some(function(file) {
						return src.indexOf(encodeURIComponent(file)) !== -1 || src.indexOf(file) !== -1;
					});
					if (isCustom) return true;

					var isOriginal = originalLogoKeys.some(function(key) {
						return src.indexOf(key) !== -1;
					});
					return isOriginal;
				});

				// Generate conflict-free repeating sequence of the custom logos
				var seq = [];
				for (var i = 0; i < marqueeImgs.length; i++) {
					var logoIndex = i % logoFiles.length;
					if (i > 0 && logoFiles[logoIndex] === seq[i - 1]) {
						logoIndex = (logoIndex + 1) % logoFiles.length;
					}
					if (i === marqueeImgs.length - 1 && i > 0 && logoFiles[logoIndex] === seq[0]) {
						logoIndex = (logoIndex + 1) % logoFiles.length;
						if (logoFiles[logoIndex] === seq[i - 1]) {
							logoIndex = (logoIndex + 1) % logoFiles.length;
						}
					}
					seq.push(logoFiles[logoIndex]);
				}

				marqueeImgs.forEach(function(img, index) {
					var logoFile = seq[index];
					var newSrc = basePath + logoFile;
					if (img.getAttribute('src') !== newSrc) {
						img.src = newSrc;
						img.removeAttribute('srcset');
						var parent = img.parentElement;
						if (parent && parent.getAttribute('data-framer-background-image-wrapper') === 'true') {
							parent.style.backgroundImage = 'none';
						}
					}
				});
			}

			function replaceText() {
				var h2s = document.querySelectorAll('h2');
				h2s.forEach(function(h2) {
					var text = h2.textContent || '';
					if (text.toLowerCase().indexOf('building skills') !== -1 || text.toLowerCase().indexOf('creative growth') !== -1) {
						if (h2.textContent !== 'READY TO BUILD SOMETHING REMARKABLE?') {
							h2.textContent = 'READY TO BUILD SOMETHING REMARKABLE?';
							h2.style.textTransform = 'uppercase';
						}
					}
				});

				var h4s = document.querySelectorAll('h4');
				h4s.forEach(function(h4) {
					var text = h4.textContent || '';
					if (text.indexOf('34°03') !== -1 || text.toLowerCase().indexOf('california') !== -1) {
						if (h4.style.display !== 'none') {
							h4.style.display = 'none';
						}
					}
				});

				var inputs = document.querySelectorAll('input, textarea');
				inputs.forEach(function(input) {
					if (input.placeholder === 'Jane Smith') {
						input.placeholder = 'Adam';
					}
					if (input.value === 'Jane Smith') {
						input.value = 'Adam';
					}
				});

				var elements = document.querySelectorAll('div, span, p, label, a, h1, h2, h3, h4, h5, h6');
				elements.forEach(function(el) {
					if (el.childNodes.length === 1 && el.childNodes[0].nodeType === 3) {
						if (el.textContent.trim() === 'Jane Smith') {
							el.textContent = 'Adam';
						}
					}
				});

				var badges = document.querySelectorAll('#__framer-badge-container, .__framer-badge, .framer-badge, a[href*="framer.com"]');
				badges.forEach(function(badge) {
					badge.style.setProperty('display', 'none', 'important');
					badge.style.setProperty('visibility', 'hidden', 'important');
					badge.style.setProperty('opacity', '0', 'important');
					badge.style.setProperty('pointer-events', 'none', 'important');
					badge.remove();
				});

				replaceMainHeading();
				rebuildBrandingList();
				rebuildWebDevList();
				replaceSection1Image();
			}

			function replaceMainHeading() {
				var elements = document.querySelectorAll('h1, h2, h3, h4, p, span, div');
				elements.forEach(function(el) {
					if (el.id === 'main' || el.tagName === 'BODY' || el.tagName === 'HTML') return;
					
					var text = el.textContent || '';
					var upperText = text.toUpperCase();
					
					// Case 1: Single element containing both lines
					if (upperText.indexOf('CREATIVE SOLUTIONS') !== -1 && upperText.indexOf('MODERN BRANDS') !== -1) {
						if (el.innerHTML.indexOf('DESIGNED FOR VISIBILITY') === -1) {
							el.innerHTML = '<span style="font-weight: 400;">DESIGNED FOR </span><span style="font-weight: 700;">VISIBILITY</span><br><span style="font-weight: 700;">BUILT</span><span style="font-weight: 400;"> FOR </span><span style="font-weight: 700;">IMPACT</span>';
						}
					}
					// Case 2: Separate element for line 1
					else if (upperText.indexOf('CREATIVE SOLUTIONS') !== -1) {
						if (el.innerHTML.indexOf('DESIGNED FOR VISIBILITY') === -1) {
							el.innerHTML = '<span style="font-weight: 400;">DESIGNED FOR </span><span style="font-weight: 700;">VISIBILITY</span>';
						}
					}
					// Case 3: Separate element for line 2
					else if (upperText.indexOf('MODERN BRANDS') !== -1) {
						if (el.innerHTML.indexOf('BUILT FOR IMPACT') === -1) {
							el.innerHTML = '<span style="font-weight: 700;">BUILT</span><span style="font-weight: 400;"> FOR </span><span style="font-weight: 700;">IMPACT</span>';
						}
					}
				});
			}

			function rebuildBrandingList() {
				var elements = document.querySelectorAll('*');
				elements.forEach(function(el) {
					if (el.children.length > 0) return;
					var text = (el.textContent || '').trim();
					
					if (text === 'Brand Strategy') {
						el.textContent = 'Logo Design';
					} else if (text === 'Visual Identity Design') {
						el.textContent = 'Brand Guidelines';
					} else if (text === 'Logo Animation') {
						el.textContent = 'Packaging Design';
					} else if (text === 'Mascot & Character Design') {
						el.textContent = 'Presentation Design';
					} else if (text === 'Branding Assets') {
						el.textContent = 'Marketing Collateral';
					}
				});
			}

			function getListInfo(anchorText) {
				var anchorEl = null;
				var elements = document.querySelectorAll('*');
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].children.length === 0 && (elements[i].textContent || '').trim() === anchorText) {
						anchorEl = elements[i];
						break;
					}
				}
				if (!anchorEl) return null;

				var current = anchorEl;
				while (current && current.parentElement) {
					var parent = current.parentElement;
					var siblings = Array.from(parent.children);
					if (siblings.length >= 2) {
						var hasOther = siblings.some(function(sib) {
							var txt = sib.textContent || '';
							return sib !== current && (txt.indexOf('E-Commerce Solutions') !== -1 || txt.indexOf('Framer & Webflow') !== -1 || txt.indexOf('Web Development') !== -1);
						});
						if (hasOther) {
							return {
								row: current,
								container: parent
							};
						}
					}
					current = parent;
				}
				return null;
			}

			function rebuildWebDevList() {
				var info = getListInfo('UI/UX Design');
				if (!info) return;
				
				var container = info.container;
				var rows = Array.from(container.children);
				
				var alreadyDone = rows.length === 5 && rows.some(function(r) {
					return r.textContent.indexOf('Website Maintenance & Optimization') !== -1;
				});
				
				if (alreadyDone) {
					updateRow(container.children[0], '[01]', 'UI/UX Design');
					updateRow(container.children[1], '[02]', 'Responsive Website Design');
					updateRow(container.children[2], '[03]', 'Web Development');
					updateRow(container.children[3], '[04]', 'E-Commerce Solutions');
					updateRow(container.children[4], '[05]', 'Website Maintenance & Optimization');
					return;
				}
				
				var rowUIUX = null;
				var rowFramer = null;
				var rowEcom = null;
				
				rows.forEach(function(r) {
					var txt = r.textContent || '';
					if (txt.indexOf('UI/UX Design') !== -1) {
						rowUIUX = r;
					} else if (txt.indexOf('Framer & Webflow') !== -1 || txt.indexOf('Responsive Website') !== -1) {
						rowFramer = r;
					} else if (txt.indexOf('Web Development') !== -1) {
						rowFramer = r;
					} else if (txt.indexOf('E-Commerce Solutions') !== -1) {
						rowEcom = r;
					}
				});
				
				if (!rowUIUX) return;
				
				var newRows = [];
				
				var r1 = rowUIUX;
				updateRow(r1, '[01]', 'UI/UX Design');
				newRows.push(r1);
				
				var r2 = rowFramer || r1.cloneNode(true);
				updateRow(r2, '[02]', 'Responsive Website Design');
				newRows.push(r2);
				
				var r3 = rowEcom || r1.cloneNode(true);
				updateRow(r3, '[03]', 'Web Development');
				newRows.push(r3);
				
				var r4 = r1.cloneNode(true);
				updateRow(r4, '[04]', 'E-Commerce Solutions');
				newRows.push(r4);
				
				var r5 = r1.cloneNode(true);
				updateRow(r5, '[05]', 'Website Maintenance & Optimization');
				newRows.push(r5);
				
				container.innerHTML = '';
				newRows.forEach(function(r) {
					container.appendChild(r);
				});
			}
			
			function updateRow(rowEl, numStr, textStr) {
				var elements = rowEl.querySelectorAll('*');
				var numUpdated = false;
				var textUpdated = false;
				
				elements.forEach(function(el) {
					if (el.children.length > 0) return;
					var txt = (el.textContent || '').trim();
					
					if (/^\[\d+\]$/.test(txt)) {
						if (el.textContent !== numStr) {
							el.textContent = numStr;
						}
						numUpdated = true;
					} else if (txt.length > 0 && !/^\[\d+\]$/.test(txt)) {
						if (el.textContent !== textStr) {
							el.textContent = textStr;
						}
						textUpdated = true;
					}
				});
				
				if (!numUpdated) {
					elements.forEach(function(el) {
						if (el.children.length > 0) return;
						var txt = (el.textContent || '').trim();
						if (txt.indexOf('[') === 0) {
							el.textContent = numStr;
							numUpdated = true;
						}
					});
				}
			}

			function replaceSection1Image() {
				var brandingHeader = null;
				var elements = document.querySelectorAll('*');
				for (var i = 0; i < elements.length; i++) {
					if (elements[i].children.length === 0 && (elements[i].textContent || '').indexOf('[001]') !== -1) {
						brandingHeader = elements[i];
						break;
					}
				}
				if (!brandingHeader) return;

				var sectionContainer = brandingHeader.parentElement;
				while (sectionContainer && sectionContainer.parentElement) {
					var imgs = sectionContainer.querySelectorAll('img');
					if (imgs.length > 0) {
						imgs.forEach(function(img) {
							var targetSrc = 'https://images.unsplash.com/photo-1626785774573-4b799315345d?auto=format&fit=crop&w=1200&q=80';
							if (img.getAttribute('src') !== targetSrc) {
								img.src = targetSrc;
								img.removeAttribute('srcset');
								var parent = img.parentElement;
								if (parent && parent.getAttribute('data-framer-background-image-wrapper') === 'true') {
									parent.style.backgroundImage = 'none';
								}
							}
						});
						break;
					}
					sectionContainer = sectionContainer.parentElement;
				}
			}

			function runAll() {
				replaceImages();
				replaceText();
			}

			runAll();
			setInterval(runAll, 100);

			var observer = new MutationObserver(function() {
				runAll();
			});
			observer.observe(document.documentElement, {
				childList: true,
				subtree: true,
				attributes: true,
				attributeFilter: ['src', 'srcset'],
				characterData: true
			});
		})();
	</script>
'@

$sourceContent = [System.IO.File]::ReadAllText($sourcePath)

$startTag = '<!-- Start of bodyEnd -->'
$endTag = '<!-- End of bodyEnd -->'

$startIdx = $sourceContent.IndexOf($startTag)
$endIdx = $sourceContent.IndexOf($endTag)

if ($startIdx -eq -1 -or $endIdx -eq -1) {
    Write-Error "Error: Could not find bodyEnd comments in source file."
    exit 1
}

$newContent = $sourceContent.Substring(0, $startIdx + $startTag.Length) + "`r`n" + $customBlock + "`r`n" + $sourceContent.Substring($endIdx)

[System.IO.File]::WriteAllText($targetPath, $newContent)
Write-Output "Successfully merged skills.html using PowerShell!"
