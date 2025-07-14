# Hotel Rasa Pro Voice Assistant

Голосовой ассистент для отеля на базе Rasa Pro с интеграцией Twilio и Azure Speech Services.

## 🏗️ Архитектура проекта

```
hotel_rasa_pro/
├── actions/              # Пользовательские действия
│   └── actions.py       # Классы действий для бронирования
├── data/                # Данные для обучения
│   └── flows.yml        # Потоки диалогов
├── models/              # Обученные модели (исключены из git)
├── config.yml           # Конфигурация Rasa
├── domain.yml           # Домен бота
├── credentials.yml      # Учетные данные (исключены из git)
├── endpoints.yml        # Конфигурация эндпоинтов
└── README.md           # Документация
```

## 🚀 Быстрый старт

### Предварительные требования

- Python 3.11+
- Rasa Pro лицензия
- Twilio аккаунт
- Azure Speech Services
- Cloudflare Tunnel (для публичного доступа)

### Установка

1. **Клонирование репозитория**
```bash
git clone <your-repo-url>
cd hotel_rasa_pro
```

2. **Создание виртуального окружения**
```bash
python3.11 -m venv .venv
source .venv/bin/activate  # Linux/Mac
# или
.venv\Scripts\activate     # Windows
```

3. **Установка зависимостей**
```bash
pip install rasa[full]
pip install rasa-sdk
```

4. **Настройка переменных окружения**
Создайте файл `.env` на основе шаблона:
```bash
# OpenAI
OPENAI_API_KEY=your_openai_key

# Azure Speech Services
AZURE_SPEECH_KEY=your_azure_speech_key
AZURE_SPEECH_REGION=eastus

# Twilio
TWILIO_ACCOUNT_SID=your_twilio_sid
TWILIO_AUTH_TOKEN=your_twilio_token
TWILIO_PHONE_NUMBER=your_twilio_phone

# Cloudflare Tunnel
CLOUDFLARE_TUNNEL_TOKEN=your_tunnel_token
```

5. **Настройка учетных данных**
Создайте `credentials.yml`:
```yaml
twilio_media_streams:
  account_sid: ${TWILIO_ACCOUNT_SID}
  auth_token: ${TWILIO_AUTH_TOKEN}
  twiML_app_sid: your_twiml_app_sid
  media_streams_app_sid: your_media_streams_app_sid
```

## 🎯 Функциональность

### Основные возможности:
- **Голосовое взаимодействие** через Twilio Media Streams
- **Распознавание речи** на русском языке (Azure Speech)
- **Синтез речи** с естественным голосом (Azure TTS)
- **Бронирование номеров** с интеграцией в систему отеля
- **Обработка намерений** с помощью LLM (OpenAI)

### Потоки диалогов:
1. **Приветствие** - начало сессии
2. **Бронирование** - создание брони
3. **Информация** - справочная информация

## 🔧 Конфигурация

### Rasa Pro настройки
- **LLM**: OpenAI GPT-4 для обработки намерений
- **Политики**: FlowPolicy для управления диалогами
- **NLU**: Компактный генератор команд

### Azure Speech Services
- **Язык**: ru-RU (Русский)
- **Голос**: ru-RU-SvetlanaNeural
- **Регион**: East US

### Twilio Media Streams
- **Webhook**: /webhooks/twilio_media_streams/webhook
- **WebSocket**: /webhooks/twilio_media_streams/websocket

## 🚀 Запуск

### 1. Запуск Action Server
```bash
rasa run actions &
```

### 2. Запуск основного сервера
```bash
rasa run --enable-api --cors "*" --port 5005 &
```

### 3. Запуск Cloudflare Tunnel (опционально)
```bash
cloudflared tunnel --url http://localhost:5005
```

## 🧪 Тестирование

### Локальное тестирование
```bash
# Тест API
curl -X POST http://localhost:5005/webhooks/twilio_media_streams/webhook \
  -H "Content-Type: application/json" \
  -d '{"From": "+1234567890", "Body": "Привет"}'
```

### Twilio тестирование
1. Настройте webhook URL в Twilio Console
2. Укажите URL: `https://your-domain.com/webhooks/twilio_media_streams/webhook`
3. Протестируйте звонок

## 📝 Пользовательские действия

### ActionSessionStart
Инициализирует новую сессию пользователя.

### ActionCreateBooking
Создает бронирование в системе отеля.

## 🔒 Безопасность

- Все чувствительные данные хранятся в переменных окружения
- Файл `credentials.yml` исключен из git
- Используется HTTPS для всех внешних соединений

## 🐛 Устранение неполадок

### Ошибка "Model not found"
```bash
rasa train
```

### Ошибка "Port already in use"
```bash
lsof -ti:5005 | xargs kill -9
lsof -ti:5055 | xargs kill -9
```

### Проблемы с Azure Speech
- Проверьте правильность ключа и региона
- Убедитесь в активной подписке Azure

## 📞 Поддержка

При возникновении проблем:
1. Проверьте логи сервера
2. Убедитесь в правильности конфигурации
3. Проверьте статус внешних сервисов

## 📄 Лицензия

Проект использует Rasa Pro лицензию. Убедитесь в наличии действующей лицензии.

---

**Версия**: 1.0.0  
**Последнее обновление**: 2025-07-13  
**Автор**: Hotel Rasa Pro Team 