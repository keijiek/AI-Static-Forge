# 使い方

## 前提

実行環境として次のいずれかを想定している。

- シェル
  - windows の git-bash
  - wsl の ubuntu
- node がインストール済み

## コマンド

次のコマンドでひな形作成を行う。

```bash
bash setup.sh
```

※上記コマンドの実行後 setup.sh は削除可。コマンドは次。

```bash
rm setup.sh
```

---

## パッケージのインストール

```bash
npm i -D vite tailwindcss @tailwindcss/vite vite-plugin-handlebars fast-glob
npm i alpinejs swiper gsap lucide
```

### swiper

カルーセルを簡単に作るためのパッケージ。

- [公式サイト](https://swiperjs.com/)
- [公式->デモ](https://swiperjs.com/demos)

### lucide

多数のアイコンを簡単に導入できるパッケージ。
lucideIcons.js などで createIcon


## ファイル・ディレクトリ作成

### vite.config.js

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

### src/js ディレクトリ作成

```bash
mkdir -p ./src/js/{swiper,lucide,alpinejs,gsap}
```

### src/js/app.js 作成

```bash
cat <<'EOF' > ./src/js/app.js
import "../css/app.css";
import Alpine from "alpinejs";

window.Alpine = Alpine;
Alpine.start();
EOF
```

### src/css ディレクトリ作成

```bash
mkdir -p ./src/css
```

### src/css/app.css 作成

```bash
printf '@import "tailwindcss";\n' > ./src/css/app.css
```

### partials 作成

```bash
mkdir -p ./src/partials
```

### head.hbs, header.hbs, footer.hbs 作成

```bash
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

### index.html 作成

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

### second.html 作成

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

### package.json に script を追加

```bash
npm pkg set scripts.dev="vite"
npm pkg set scripts.build="vite build"
npm pkg set scripts.preview="vite preview"
```

---

## シェルスクリプト(setup.sh)の実行

※setup.sh は、上記までの処理がすべて実行されるスクリプト。下記コマンドで実行。

```bash
bash setup.sh
```
