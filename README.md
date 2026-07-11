# Agri Data Collection App

Myanmar field data collection apps (Android + Windows) for AI training datasets.

## Download website

| Platform | Link |
|----------|------|
| Cloudflare (PC / Wi‑Fi) | https://agri-data-collect.minthwayhan53.workers.dev |
| GitHub Pages (phone-friendly backup) | https://mthhan.github.io/Agro_Data_Collection_App/ |
| Direct Android APK | https://github.com/MTHhan/Agro_Data_Collection_App/releases/download/v1.0.0/Agro.Data.apk |
| Direct Windows EXE | https://github.com/MTHhan/Agro_Data_Collection_App/releases/download/v1.0.0/Agro_Data_Desktop.exe |

> Some Myanmar mobile networks time out on `*.workers.dev`. If the phone cannot open Cloudflare, use **GitHub Pages** or the direct download links above.

## Enable GitHub Pages (one-time)

1. Open repo **Settings → Pages**
2. Under **Build and deployment → Source**, choose **GitHub Actions**
3. Push to `main` (or re-run the **Deploy website to GitHub Pages** workflow)

## Update website after edits

```powershell
cd D:\New_Data_Collect\Agro_Data_Collection_App
git add website/index.html
git commit -m "Update website"
git push origin main
```
