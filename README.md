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
| `usr/share/tarsila/applications/tarsila-email.desktop` | Atalho curado |

## Build

```bash
./build-deb.sh [versão]   # padrão: 2.1.0
```

Gera `tarsila-email_<versão>_all.deb`.

## Dependências (apt)

`python3`, `python3-gi`, `python3-gi-cairo`, `gir1.2-gtk-3.0`,
`gir1.2-gdkpixbuf-2.0`, `fonts-roboto`, `xdg-utils` (Recommends:
`libnotify-bin`).
