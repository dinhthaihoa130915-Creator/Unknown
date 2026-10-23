import tkinter as tk

# Khởi tạo giao diện chính
root = tk.Tk()
root.title("Fly GUI V3 - Cyberpunk (Python)")
root.geometry("250x130")
root.configure(bg="#0d0d12")
root.resizable(False, False)

# Biến trạng thái
speed = 1
is_flying = False

# Tiêu đề
title_label = tk.Label(
    root,
    text="★彡 Рussу Uиkиоши 彡모",
    bg="#280a2d",
    fg="#ff6edc",
    font=("Arial", 10, "bold")
)
title_label.pack(fill="x", ipady=6)

# Khung chứa các nút điều khiển tốc độ và trạng thái
frame = tk.Frame(root, bg="#0d0d12")
frame.pack(pady=10)

# Hàm tăng/giảm tốc độ
def decrease_speed():
    global speed
    speed = max(1, speed - 1)
    speed_label.config(text=f"SPEED: {speed}")

def increase_speed():
    global speed
    speed += 1
    speed_label.config(text=f"SPEED: {speed}")

def toggle_fly():
    global is_flying
    is_flying = not is_flying
    if is_flying:
        fly_btn.config(text="🔥 UNFLY (ON)", bg="#e11d48")
    else:
        fly_btn.config(text="🚀 FLY (OFF)", bg="#8c00ff")

# Nút Giảm (-)
minus_btn = tk.Button(
    frame, text="-", bg="#ef4444", fg="white", font=("Arial", 10, "bold"),
    width=3, bd=0, command=decrease_speed
)
minus_btn.grid(row=0, column=0, padx=4)

# Nhãn hiển thị Tốc độ
speed_label = tk.Label(
    frame, text=f"SPEED: {speed}", bg="#191923", fg="#00f5ff",
    font=("Arial", 10, "bold"), width=12, height=1
)
speed_label.grid(row=0, column=1, padx=4)

# Nút Tăng (+)
plus_btn = tk.Button(
    frame, text="+", bg="#22c55e", fg="white", font=("Arial", 10, "bold"),
    width=3, bd=0, command=increase_speed
)
plus_btn.grid(row=0, column=2, padx=4)

# Nút Fly / Unfly
fly_btn = tk.Button(
    root, text="🚀 FLY (OFF)", bg="#8c00ff", fg="white", font=("Arial", 10, "bold"),
    width=28, bd=0, command=toggle_fly
)
fly_btn.pack(pady=5)

root.mainloop()
