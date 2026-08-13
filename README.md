# tarsila-email

Cliente de e-mail nativo do **Tarsila OS** — pacote Debian separado.

## O que é

Cliente GTK3 **100% standalone** (sem WebKit, sem Claws Mail) com:
- Sync bidirecional Gmail via IMAP/SMTP
- Cache SQLite local (`mail.db`)
- Notificações IMAP IDLE em tempo real
- UI estilo Gmail

## Componentes

| Arquivo | Função |
|---|---|
| `bin/tarsila-email-gtk.py` | UI principal GTK3 |
| `bin/tarsila-email-backend.py` | API REST local (porta 8475) |
| `bin/tarsila-email-idle.py` | Daemon IMAP IDLE + notify-send |
| `bin/tarsila-email-setup.py` | Assistente de configuração (Gmail) |
| `lib/` | config, db, imap_sync, smtp_send, avatar, api_client |
| `ui/` | CSS, ícones, SPA de fallback |
| `usr/local/bin/tarsila-email` | Launcher |
| `usr/share/applications/tarsila-email.desktop` | Atalho genérico (menu XDG de qualquer Debian) |

## Integração com o Tarsila OS

O `.desktop` é instalado apenas em `/usr/share/applications/` (XDX padrão).
No Tarsila OS, o **app-manager** (`tarsila-atalho-criar`) adota o app no
catálogo curado (`/usr/share/tarsila/applications/`), adicionando as ações
de dock e desinstalação. Isso é feito pelo `install.sh` do core na instalação,
ou pelo app-manager depois (migração/duplo clique).

## Build

```bash
./build-deb.sh [versão]   # padrão: 2.1.0
```

Gera `tarsila-email_<versão>_all.deb`.

## Dependências (apt)

`python3`, `python3-gi`, `python3-gi-cairo`, `gir1.2-gtk-3.0`,
`gir1.2-gdkpixbuf-2.0`, `fonts-roboto`, `xdg-utils` (Recommends:
`libnotify-bin`).
