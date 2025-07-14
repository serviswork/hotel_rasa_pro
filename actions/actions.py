from rasa_sdk import Action, Tracker
from rasa_sdk.events import SlotSet
from rasa_sdk.executor import CollectingDispatcher
import logging

logger = logging.getLogger(__name__)

class ActionSessionStart(Action):
    def name(self) -> str:
        return "action_session_start"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict) -> list:
        metadata = tracker.get_slot("session_started_metadata")
        logger.info(f"Hotel call started: {metadata}")
        return []

class ActionCreateBooking(Action):
    def name(self) -> str:
        return "action_create_booking"

    def run(self, dispatcher: CollectingDispatcher, tracker: Tracker, domain: dict) -> list:
        guest_name = tracker.get_slot("guest_name")
        check_in = tracker.get_slot("check_in_date")
        check_out = tracker.get_slot("check_out_date")
        room_type = tracker.get_slot("room_type")
        
        # Здесь можно добавить интеграцию с системой бронирования отеля
        logger.info(f"Booking created: {guest_name}, {check_in}-{check_out}, {room_type}")
        return []
