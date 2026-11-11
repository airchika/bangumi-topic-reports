# Bangumi 分析报告发布

此仓库只保存准备公开的网站文件和部署配置。首页为“番剧评论 · 时间动态榜”。
`public/index.html` 是生成报告的原样副本，包含页面所需的代码与数据。

## Cloudflare 首次部署

使用 Workers 的 Connect GitHub 入口，选择本仓库：

- 项目 / Worker 名称：`bangumi-topic-reports`（与 wrangler.jsonc 保持一致）
- 生产分支：`main`
- 根目录：仓库根目录（留空或界面默认的 `/`）
- Build command：留空，网页已生成，不需重新构建
- Deploy command：`npm run deploy`
- 不需要配置数据库或环境变量

Cloudflare 安装 package-lock.json 中固定的依赖后，以 Workers Static Assets 发布 public 目录。
仓库与网站均公开，网页及其内嵌数据可被所有访客读取。

## 在原分析项目中更新报告

WorkBuddy 继续生成 `../reports/anime-timeline-ranking.html`。
在本目录执行：

```powershell
./update-report.ps1
git diff --stat
git add public/index.html
git commit -m "Update anime timeline report"
git push
```

脚本只复制报告，不会自动提交或推送。推送 main 后 Cloudflare 自动更新网站。
独立克隆本仓库时，用 `./update-report.ps1 -SourcePath '报告的绝对路径'` 指定来源。

## 本地预览与部署检查

```powershell
npm ci
npm run dev
```

运行 `npm run check:deploy` 可检查部署配置，不会发布线上网站。

网页中内嵌第三方图表库，保留原报告已有的许可证声明。
