#!/bin/bash

# Hotel Rasa Pro Setup Script
# Автоматическая настройка проекта

echo "🏨 Настройка Hotel Rasa Pro проекта..."

# Проверка Python версии
echo "📋 Проверка Python версии..."
python3.11 --version || {
    echo "❌ Python 3.11 не найден. Установите Python 3.11+"
    exit 1
}

# Создание виртуального окружения
echo "🔧 Создание виртуального окружения..."
python3.11 -m venv .venv

# Активация виртуального окружения
echo "⚡ Активация виртуального окружения..."
source .venv/bin/activate

# Обновление pip
echo "📦 Обновление pip..."
pip install --upgrade pip

# Установка зависимостей
echo "📚 Установка зависимостей..."
pip install rasa[full]
pip install rasa-sdk

# Проверка наличия .env файла
if [ ! -f .env ]; then
    echo "⚠️  Файл .env не найден!"
    echo "📝 Создайте файл .env на основе env.template"
    echo "🔑 Добавьте необходимые API ключи"
else
    echo "✅ Файл .env найден"
fi

# Проверка наличия credentials.yml
if [ ! -f credentials.yml ]; then
    echo "⚠️  Файл credentials.yml не найден!"
    echo "📝 Создайте файл credentials.yml с настройками Twilio"
else
    echo "✅ Файл credentials.yml найден"
fi

# Обучение модели
echo "🤖 Обучение модели..."
rasa train

echo "✅ Настройка завершена!"
echo ""
echo "🚀 Для запуска используйте:"
echo "  1. rasa run actions &"
echo "  2. rasa run --enable-api --cors '*' --port 5005 &"
echo ""
echo "📞 Для тестирования Twilio настройте webhook:"
echo "   https://your-domain.com/webhooks/twilio_media_streams/webhook" 