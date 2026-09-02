const fs = require('fs');
const path = require('path');

const seoData = {
    'index.html': {
        title: 'Griffiq | Creative Media Agency',
        description: 'Griffiq is a creative media agency helping brands grow through strategic branding, engaging content, and social-first marketing that drives measurable results.',
        canonical: 'https://www.griffiq.com/'
    },
    'about.html': {
        title: 'About Us | Griffiq Creative Media Agency',
        description: 'Learn more about Griffiq, a creative media agency dedicated to helping businesses grow with innovative branding and social-first marketing strategies.',
        canonical: 'https://www.griffiq.com/about.html'
    },
    'services.html': {
        title: 'Our Services | Griffiq Creative Media Agency',
        description: 'Explore the creative services offered by Griffiq, including strategic branding, engaging content creation, and measurable social-first marketing.',
        canonical: 'https://www.griffiq.com/services.html'
    },
    'work.html': {
        title: 'Portfolio & Work | Griffiq Creative Media Agency',
        description: 'View our portfolio at Griffiq to see how we have helped businesses grow through strategic branding and creative social media marketing.',
        canonical: 'https://www.griffiq.com/work.html'
    },
    'contact-us.html': {
        title: 'Contact Us | Griffiq Creative Media Agency',
        description: 'Get in touch with Griffiq, your creative media agency. Let us help your brand grow with our strategic and engaging marketing solutions.',
        canonical: 'https://www.griffiq.com/contact-us.html'
    },
    'privacy-policy.html': {
        title: 'Privacy Policy | Griffiq Creative Media Agency',
        description: 'Read the Privacy Policy for Griffiq to understand how we collect, use, and protect your information.',
        canonical: 'https://www.griffiq.com/privacy-policy.html'
    },
    'terms-and-conditions.html': {
        title: 'Terms and Conditions | Griffiq Creative Media Agency',
        description: 'Review the Terms and Conditions for using Griffiq services and website.',
        canonical: 'https://www.griffiq.com/terms-and-conditions.html'
    },
    'work/https-brand-bookshelf.vercel.app.html': {
        title: 'Brand Bookshelf Project | Griffiq Creative Media Agency',
        description: 'Check out the Brand Bookshelf project by Griffiq, showcasing our expertise in branding and web development.',
        canonical: 'https://www.griffiq.com/work/https-brand-bookshelf.vercel.app.html'
    },
    'work/https-kalyanidevelopers.com.html': {
        title: 'Kalyani Developers Project | Griffiq Creative Media Agency',
        description: 'Discover the Kalyani Developers project delivered by Griffiq, a testament to our creative marketing and branding capabilities.',
        canonical: 'https://www.griffiq.com/work/https-kalyanidevelopers.com.html'
    },
    'work/https-seekneo.com.html': {
        title: 'Seekneo Project | Griffiq Creative Media Agency',
        description: 'View the Seekneo project by Griffiq. See how we drive growth through engaging content and strategic branding.',
        canonical: 'https://www.griffiq.com/work/https-seekneo.com.html'
    },
    'work/https-www.dzinemakers.com.html': {
        title: 'DzineMakers Project | Griffiq Creative Media Agency',
        description: 'Explore the DzineMakers project by Griffiq, highlighting our innovative approach to social-first marketing.',
        canonical: 'https://www.griffiq.com/work/https-www.dzinemakers.com.html'
    },
    'work/https-www.makemyreach.com.html': {
        title: 'Make My Reach Project | Griffiq Creative Media Agency',
        description: 'Check out the Make My Reach project crafted by Griffiq. Measurable results through creative media.',
        canonical: 'https://www.griffiq.com/work/https-www.makemyreach.com.html'
    },
    'work/https-www.vscalemedia.com.html': {
        title: 'Vscale Media Project | Griffiq Creative Media Agency',
        description: 'Discover the Vscale Media project by Griffiq, showcasing our strategic branding and digital marketing expertise.',
        canonical: 'https://www.griffiq.com/work/https-www.vscalemedia.com.html'
    }
};

const structuredData = `
    <!-- Structured Data -->
    <script type="application/ld+json">
    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "Organization",
          "name": "Griffiq",
          "url": "https://www.griffiq.com/",
          "logo": "https://www.griffiq.com/griffiq_logo.png",
          "description": "Creative Media Agency helping brands grow."
        },
        {
          "@type": "WebSite",
          "name": "Griffiq",
          "url": "https://www.griffiq.com/"
        }
      ]
    }
    </script>
`;

const seoFooter = `
    <style>
      .sr-only { position: absolute; width: 1px; height: 1px; padding: 0; margin: -1px; overflow: hidden; clip: rect(0, 0, 0, 0); white-space: nowrap; border: 0; }
      .seo-footer { padding: 40px 20px; background: #111; color: #fff; text-align: center; font-family: sans-serif; position: relative; z-index: 9999; }
      .seo-footer a { color: #ccc; margin: 0 10px; text-decoration: none; font-size: 14px; }
      .seo-footer a:hover { text-decoration: underline; color: #fff; }
      .seo-footer p { margin-bottom: 20px; font-weight: bold; font-size: 16px; }
    </style>
    <footer class="seo-footer">
      <p>Griffiq - Creative Media Agency</p>
      <nav aria-label="Footer Navigation">
        <a href="https://www.griffiq.com/">Home</a>
        <a href="https://www.griffiq.com/about.html">About Us</a>
        <a href="https://www.griffiq.com/services.html">Services</a>
        <a href="https://www.griffiq.com/work.html">Portfolio</a>
        <a href="https://www.griffiq.com/contact-us.html">Contact Us</a>
        <a href="https://www.griffiq.com/privacy-policy.html">Privacy Policy</a>
        <a href="https://www.griffiq.com/terms-and-conditions.html">Terms and Conditions</a>
      </nav>
    </footer>
`;

function processFile(filePath) {
    if (!seoData[filePath]) return;
    const { title, description, canonical } = seoData[filePath];
    let content = fs.readFileSync(filePath, 'utf8');

    // Replace Title
    content = content.replace(/<title>.*?<\/title>/gi, `<title>${title}</title>`);
    
    // Replace Meta Description
    content = content.replace(/<meta name="description" content="[^"]*">/gi, `<meta name="description" content="${description}">`);
    
    // Replace OG Title
    content = content.replace(/<meta property="og:title" content="[^"]*">/gi, `<meta property="og:title" content="${title}">`);
    
    // Replace OG Description
    content = content.replace(/<meta property="og:description" content="[^"]*">/gi, `<meta property="og:description" content="${description}">`);
    
    // Replace Twitter Title
    content = content.replace(/<meta name="twitter:title" content="[^"]*">/gi, `<meta name="twitter:title" content="${title}">`);
    
    // Replace Twitter Description
    content = content.replace(/<meta name="twitter:description" content="[^"]*">/gi, `<meta name="twitter:description" content="${description}">`);
    
    // Replace Canonical
    content = content.replace(/<link rel="canonical" href="[^"]*">/gi, `<link rel="canonical" href="${canonical}">`);
    
    // Replace OG URL
    content = content.replace(/<meta property="og:url" content="[^"]*">/gi, `<meta property="og:url" content="${canonical}">`);

    // Remove any noindex
    content = content.replace(/<meta name="robots" content="noindex[^"]*">/gi, '');

    // Add Structured Data to index.html
    if (filePath === 'index.html' && !content.includes('application/ld+json')) {
        content = content.replace('</head>', `${structuredData}</head>`);
    }

    // Add H1
    const h1Tag = `<h1 class="sr-only">${title}</h1>`;
    // Find body or main to inject H1
    if (content.includes('<div id="main">') && !content.includes('<h1 class="sr-only">')) {
        content = content.replace('<div id="main">', `${h1Tag}\n<div id="main">`);
    } else if (content.includes('<body>') && !content.includes('<h1 class="sr-only">')) {
        content = content.replace('<body>', `<body>\n${h1Tag}`);
    }

    // Add SEO Footer
    if (!content.includes('class="seo-footer"')) {
        if (content.includes('</body>')) {
            content = content.replace('</body>', `${seoFooter}\n</body>`);
        } else {
            content += seoFooter;
        }
    }

    fs.writeFileSync(filePath, content, 'utf8');
    console.log(`Updated ${filePath}`);
}

Object.keys(seoData).forEach(processFile);
