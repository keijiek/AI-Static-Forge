#!/usr/bin/env bash

set -e

printf '{}\n' > package.json
npm i -D vite tailwindcss @tailwindcss/vite vite-plugin-handlebars fast-glob
npm i alpinejs lucide swiper gsap

cat <<'EOF' > ./vite.config.js
import { defineConfig } from 'vite'
import tailwindcss from '@tailwindcss/vite'
import { resolve } from 'path'
import fg from 'fast-glob'
import handlebars from 'vite-plugin-handlebars'

const htmlFiles = fg.sync(['*.html', '**/*.html'], {
  ignore: ['dist/**', 'node_modules/**'],
})

const input = Object.fromEntries(
  htmlFiles.map((file) => [
    file.replace(/\.html$/, ''),
    resolve(__dirname, file),
  ])
)

export default defineConfig({
  plugins: [
    tailwindcss(),
    handlebars({
      partialDirectory: resolve(__dirname, './partials'),
    }),
  ],
  build: {
    rollupOptions: {
      input,
    },
  },
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
    },
  },
})
EOF

mkdir -p \
  ./imgs \
  ./partials \
  ./src/js/swiper \
  ./src/js/lucide \
  ./src/js/alpinejs \
  ./src/js/gsap \
  ./src/css

cat <<'EOF' > ./src/js/app.js
import "../css/app.css";
import "./alpinejs/alpine.js";
import "./lucide/lucideIcons.js";
EOF

cat <<'EOF' > ./src/js/alpinejs/alpine.js
import Alpine from "alpinejs";

window.Alpine = Alpine;
Alpine.start();
EOF

cat <<'EOF' > ./src/js/lucide/lucideIcons.js
import { createIcons, Phone, Mail } from "lucide";

createIcons({
  icons: {
    Phone,
    Mail,
  },
});
EOF

printf '@import "tailwindcss";\n' > ./src/css/app.css
cat <<'EOF' > ./tailwind.config.js
@import "tailwindcss";

@theme{
  --font-base : "Helvetica Neue",
    Arial,
    "Hiragino Kaku Gothic ProN",
    "Hiragino Sans",
    "Noto Sans JP",
    sans-serif;

}
EOF

cat <<'EOF' > ./partials/header.hbs
<header></header>
EOF

cat <<'EOF' > ./partials/footer.hbs
<footer></footer>
EOF

cat <<'EOF' > ./partials/head.hbs
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="module" src="/src/js/app.js"></script>
<title>vite_tailwind_alpine</title>
EOF

cat <<'EOF' > ./index.html
<!doctype html>
<html lang="ja">
  <head>
    {{> head}}
  </head>
  <body>
    {{> header}}
    <main>this is index</main>
    {{> footer}}
  </body>
</html>
EOF

cat <<'EOF' > ./sample.html
<!doctype html>
<html lang="ja">
  <head>
    {{> head}}
  </head>
  <body>
    {{> header}}
    <main>this is sample page</main>
    {{> footer}}
  </body>
</html>
EOF

npm pkg set scripts.dev="vite"
npm pkg set scripts.build="vite build"
npm pkg set scripts.preview="vite preview"

echo ""
echo "Setup complete."
echo "Run: npm run dev"
