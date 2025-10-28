# 🏥 Hospital Management System – Managing Staff Feature

## 📘 Project Description
This project is a **Hospital Management System** implemented in **Dart**, focusing on the **Managing Staff** feature.  
It demonstrates **Object-Oriented Programming (OOP)** concepts such as **inheritance, encapsulation, abstraction, and polymorphism**.  
The goal is to show how OOP principles can model real-world scenarios using a **layered architecture** (Domain, Data, and UI).

The system allows administrators to **add, view, update, and remove** different types of hospital staff — including **Doctors**, **Nurses**, and **Administrative Staff** — while keeping the design modular and reusable.

---

## 🧩 System Overview
The Managing Staff feature provides the following capabilities:

- Add new staff members to the system  
- Display all staff with detailed information  
- Update salary or department information  
- Remove staff members by ID  
- Automatically calculate bonuses based on role or experience  

---

## 🏗️ Architecture
The project follows a **3-layer architecture**:

| Layer | Description |
|--------|--------------|
| **UI Layer** | Handles user interaction via console input/output. |
| **Domain Layer** | Contains the business logic and classes (`Staff`, `Doctor`, `Nurse`, `AdministrativeStaff`, `StaffManager`). |
| **Data Layer** | (Optional) Handles data persistence such as file storage or JSON. |

