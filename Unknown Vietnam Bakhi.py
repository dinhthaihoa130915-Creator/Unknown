# --- 1. Chuỗi hàm nối tiếp ---
def tang_gia_tri(n):
    return n + 1

def giam_gia_tri(n):
    return n - 1

def buoc_trung_gian(val, buoc=200):
    for _ in range(buoc):
        val = tang_gia_tri(val)
        val = giam_gia_tri(val)
    return val

# --- 2. Tạo mã Unicode qua bước tính toán & bit ---
def tao_ma_chuoi():
    chuoi_goc = "Unknown Vietnam Dinhthaihoa"
    ma_goc = [ord(ch) for ch in chuoi_goc]
    ket_qua = []
    for m in ma_goc:
        nhi_phan = format(m, "08b")
        dao_bit = "".join("1" if b == "0" else "0" for b in nhi_phan)
        khoi_phuc_bit = "".join("1" if b == "0" else "0" for b in dao_bit)
        so_sau_buoc = buoc_trung_gian(int(khoi_phuc_bit, 2), buoc=500)
        ket_qua.append(so_sau_buoc)
    return ket_qua

# --- 3. Tự sinh file code dài nhiều dòng ---
def tao_file_dai(ten_file="unknown_vietnam_dinhthaihoa_dai.py", so_dong=100_000):
    ma_code = tao_ma_chuoi()
    with open(ten_file, "w", encoding="utf-8") as f:
        f.write("bien_dem = 0\n")
        for i in range(so_dong):
            f.write(f"bien_dem = (bien_dem + {i % 7 + 1}) - {i % 7 + 1}\n")
        f.write("if bien_dem == 0:\n")
        f.write(f"    chuoi = ''.join(chr(x) for x in {ma_code})\n")
        f.write("    print(chuoi)\n")
    print(f"Đã tạo xong {ten_file} với {so_dong + 5} dòng.")

if __name__ == "__main__":
    tao_file_dai("unknown_vietnam_dinhthaihoa_dai.py", so_dong=1000000000000000000000000000)
