const fs = require('fs');
const files = fs.readdirSync('.').filter(f => f.endsWith('.html'));
files.forEach(f => {
  let content = fs.readFileSync(f, 'utf8');
  if (content.includes('href="blog.html"')) {
    content = content.replace(/href="blog\.html"/g, 'href="about.html"');
    fs.writeFileSync(f, content, 'utf8');
    console.log('Fixed ' + f);
  }
});
