# 🚀 Быстрая справка - Hotel Rasa Pro

## 📋 Основные команды

### Запуск сервисов
```bash
# Action Server (порт 5055)
rasa run actions &

# Основной сервер (порт 5005)
rasa run --enable-api --cors "*" --port 5005 &

# Cloudflare Tunnel
cloudflared tunnel --url http://localhost:5005
```

### Обучение и тестирование
```bash
# Обучение модели
rasa train

# Тест NLU
rasa test nlu

# Тест stories
rasa test core

# Интерактивное тестирование
rasa shell
```

### Управление проектом
```bash
# Проверка конфигурации
rasa show config

# Проверка домена
rasa show domain

# Проверка потоков
rasa show flows
```

## 🔧 Устранение неполадок

### Порт занят
```bash
# Поиск процессов
lsof -ti:5005
lsof -ti:5055

# Завершение процессов
lsof -ti:5005 | xargs kill -9
lsof -ti:5055 | xargs kill -9
```

### Ошибки обучения
```bash
# Очистка кэша
rm -rf .rasa/
rm -rf models/

# Переобучение
rasa train
```

### Проблемы с переменными окружения
```bash
# Проверка переменных
echo $OPENAI_API_KEY
echo $AZURE_SPEECH_KEY

# Перезагрузка .env
source .env
```

## 📞 Twilio настройки

### Webhook URL
```
https://your-domain.com/webhooks/twilio_media_streams/webhook
```

### TwiML App настройки
- Voice Configuration: Webhook
- Voice Webhook URL: `https://your-domain.com/webhooks/twilio_media_streams/webhook`
- HTTP Method: POST

### Media Streams настройки
- Enable Media Streams: Yes
- Stream Name: audio_stream
- Track: both

## 🔍 Полезные команды

### Проверка статуса сервисов
```bash
# Проверка Rasa API
curl http://localhost:5005/status

# Проверка Action Server
curl http://localhost:5055/health
```

### Логи
```bash
# Просмотр логов в реальном времени
tail -f rasa.log

# Поиск ошибок
grep -i error rasa.log
```

## 📁 Структура файлов

```
hotel_rasa_pro/
├── actions/actions.py      # Пользовательские действия
├── data/flows.yml         # Потоки диалогов
├── config.yml             # Конфигурация Rasa
├── domain.yml             # Домен бота
├── credentials.yml        # Учетные данные (не в git)
├── endpoints.yml          # Эндпоинты
├── .env                   # Переменные окружения (не в git)
├── setup.sh              # Скрипт настройки
└── README.md             # Документация
```

## 🚨 Частые ошибки

1. **"Model not found"** → Запустите `rasa train`
2. **"Port already in use"** → Завершите процессы на портах
3. **"Invalid API key"** → Проверьте переменные окружения
4. **"Duplicate NLU trigger"** → Проверьте flows.yml на дубликаты
5. **"Webhook timeout"** → Проверьте доступность сервера

## 📞 Поддержка

- Проверьте логи: `tail -f rasa.log`
- Проверьте конфигурацию: `rasa show config`
- Проверьте домен: `rasa show domain`
- Проверьте потоки: `rasa show flows` 