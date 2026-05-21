
## パッケージ群のインストール

```bash
npm i -D vite tailwindcss @tailwindcss/vite vite-plugin-handlebars fast-glob
npm i alpinejs
```

## ファイル作成

vite.config.js

```bash
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
      partialDirectory: resolve(__dirname, './src/partials'),
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
```

src/js/app.js

```bash
mkdir -p ./src/js && cat <<'EOF' > ./src/js/app.js
import "../css/app.css";
import Alpine from "alpinejs";

window.Alpine = Alpine;
Alpine.start();
EOF
```

src/css/app.css

```bash
mkdir -p ./src/css && printf '@import "tailwindcss";\n' > ./src/css/app.css
```

head.hbs, header.hbs, footer.hbs

```bash
mkdir -p ./src/partials && \
cat <<'EOF' > ./src/partials/header.hbs
<header></header>
EOF

cat <<'EOF' > ./src/partials/footer.hbs
<footer></footer>
EOF

cat <<'EOF' > ./src/partials/head.hbs
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script type="module" src="/src/js/app.js"></script>
<title>vite_tailwind_alpine</title>
EOF
```

index.html

```bash
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
```

second.html

```bash
cat <<'EOF' > ./second.html
<!doctype html>
<html lang="ja">
  <head>
    {{> head}}
  </head>
  <body>
    {{> header}}
    <main>this is second page</main>
    {{> footer}}
  </body>
</html>
EOF
```

package.json に script を追加

```bash
npm pkg set scripts.dev="vite"
npm pkg set scripts.build="vite build"
npm pkg set scripts.preview="vite preview"
```

---

## シェルスクリプト

```bash
bash setup.sh
```

---

## 一括コマンド

```bash
npm i -D vite tailwindcss @tailwindcss/vite vite-plugin-handlebars fast-glob
npm i alpinejs

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
      partialDirectory: resolve(__dirname, './src/partials'),
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

mkdir -p ./src/js && cat <<'EOF' > ./src/js/app.js
import "../css/app.css";
import Alpine from "alpinejs";

window.Alpine = Alpine;
Alpine.start();
EOF

mkdir -p ./src/css && cat <<'EOF' > ./src/css/app.css
@import "tailwindcss";
EOF

mkdir -p ./src/partials

cat <<'EOF' > ./src/partials/header.hbs
<header></header>
EOF

cat <<'EOF' > ./src/partials/footer.hbs
<footer></footer>
EOF

cat <<'EOF' > ./src/partials/head.hbs
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

cat <<'EOF' > ./second.html
<!doctype html>
<html lang="ja">
  <head>
    {{> head}}
  </head>
  <body>
    {{> header}}
    <main>this is second page</main>
    {{> footer}}
  </body>
</html>
EOF

npm pkg set scripts.dev="vite"
npm pkg set scripts.build="vite build"
npm pkg set scripts.preview="vite preview"
```