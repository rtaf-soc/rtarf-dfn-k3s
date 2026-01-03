0. Create .env from .env-template
1. Run initial secrets
2. Run initial addons
3. Run initial git manifests
   - Create "local-apps" repository
   - Clone code from https://github.com/rtaf-soc/rtarf-dfn-apps.git
   - Replace repoUrl with "http://gitea.gitea.svc.cluster.local:3000/admin/local-apps.git" instead
   - Push to "local-apps"

3. Run bootstrap
