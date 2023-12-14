import enum
from datetime import datetime
from typing import Optional, List, NewType
from pydantic import BaseModel, EmailStr, Field, validator

# Define NewType for IDs
UserTypeID = NewType("UserTypeID", int)
UserID = NewType("UserID", int)
ClassID = NewType("ClassID", int)
RoomID = NewType("RoomID", int)
MessageID = NewType("MessageID", int)
AIInteractionID = NewType("AIInteractionID", int)

# UserTypes Models
class UserType(BaseModel):
    id: UserTypeID
    type_description: str

class UserTypeFilter(BaseModel):
    user_type_id: Optional[UserTypeID]
    user_type_ids: Optional[List[UserTypeID]]
    type_description: Optional[str]

# Users Models


class UnsavedUser(BaseModel):
    username: str
    user_type_id: UserTypeID
    email: EmailStr
    password: str

class User(BaseModel):
    id: UserID
    username: str
    user_type_id: UserTypeID
    email: EmailStr
    created_at: datetime
    updated_at: datetime

class PartialUpdateUser(BaseModel):
    username: Optional[str]
    user_type_id: Optional[UserTypeID]
    email: Optional[EmailStr]

class UserFilter(BaseModel):
    user_id: Optional[UserID]
    user_ids: Optional[List[UserID]]
    username: Optional[str]
    user_type_id: Optional[UserTypeID]
    email: Optional[EmailStr]

# Classes Models


class UnsavedClass(BaseModel):
    class_name: str
    teacher_id: UserID

class Class(BaseModel):
    id: ClassID
    class_name: str
    teacher_id: UserID

class PartialUpdateClass(BaseModel):
    class_name: Optional[str]
    teacher_id: Optional[UserID]

class ClassFilter(BaseModel):
    class_id: Optional[ClassID]
    class_ids: Optional[List[ClassID]]
    class_name: Optional[str]
    teacher_id: Optional[UserID]

# Rooms Models


class UnsavedRoom(BaseModel):
    name: str
    class_id: ClassID
    ai_instructions: Optional[str]

class Room(BaseModel):
    id: RoomID
    name: str
    class_id: ClassID
    ai_instructions: Optional[str]
    created_at: datetime
    updated_at: datetime

class PartialUpdateRoom(BaseModel):
    class_id: Optional[ClassID]
    ai_instructions: Optional[str]

class RoomFilter(BaseModel):
    room_id: Optional[RoomID]
    room_ids: Optional[List[RoomID]]
    name: str
    class_id: Optional[ClassID]

# Messages Models


class UnsavedMessage(BaseModel):
    room_id: RoomID
    sender_id: UserID
    content: str

class Message(BaseModel):
    id: MessageID
    room_id: RoomID
    sender_id: UserID
    content: str
    created_at: datetime

class PartialUpdateMessage(BaseModel):
    content: Optional[str]

class MessageFilter(BaseModel):
    message_id: Optional[MessageID]
    message_ids: Optional[List[MessageID]]
    room_id: Optional[RoomID]
    sender_id: Optional[UserID]
    content: Optional[str]

# AI Interactions Models

class UnsavedAIInteraction(BaseModel):
    student_id: UserID
    room_id: RoomID
    ai_response: Optional[str]

class AIInteraction(BaseModel):
    id: AIInteractionID
    student_id: UserID
    room_id: RoomID
    ai_response: Optional[str]
    created_at: datetime


class PartialUpdateAIInteraction(BaseModel):
    ai_response: Optional[str]

class AIInteractionFilter(BaseModel):
    ai_interaction_id: Optional[AIInteractionID]
    ai_interaction_ids: Optional[List[AIInteractionID]]
    student_id: Optional[UserID]
    room_id: Optional[RoomID]
    ai_response: Optional[str]
