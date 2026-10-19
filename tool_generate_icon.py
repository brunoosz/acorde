import zlib
import struct
import math

def create_acorde_icon(filename="assets/icons/acorde-icon-1024.png", size=1024):
    width = size
    height = size

    # Paleta Navigate
    bg_r, bg_g, bg_b = 20, 20, 20       # #141414
    dot_r, dot_g, dot_b = 255, 109, 56   # #ff6d38 (Laranja)
    cream_r, cream_g, cream_b = 253, 249, 240 # #fdf9f0 (Creme)

    # Criação do buffer de imagem RGBA
    # Cada linha do PNG começa com o byte de filtro 0
    raw_rows = []

    # Centro e raio do ponto laranja
    dot_cx = int(width * 0.66)
    dot_cy = int(height * 0.66)
    dot_r_sq = int((width * 0.08) ** 2)

    # Letra 'a' estilizada (arco exterior e interior + haste lateral)
    # Centro do corpo do 'a'
    body_cx = int(width * 0.38)
    body_cy = int(height * 0.55)
    r_outer_sq = int((width * 0.22) ** 2)
    r_inner_sq = int((width * 0.12) ** 2)
    
    # Haste vertical direita do 'a'
    stem_x1 = int(width * 0.46)
    stem_x2 = int(width * 0.58)
    stem_y1 = int(height * 0.35)
    stem_y2 = int(height * 0.77)

    for y in range(height):
        row = [0] # filter byte
        for x in range(width):
            # 1. Ponto laranja
            dx_dot = x - dot_cx
            dy_dot = y - dot_cy
            if dx_dot * dx_dot + dy_dot * dy_dot <= dot_r_sq:
                row.extend([dot_r, dot_g, dot_b, 255])
                continue

            # 2. Haste do 'a'
            if stem_x1 <= x <= stem_x2 and stem_y1 <= y <= stem_y2:
                row.extend([cream_r, cream_g, cream_b, 255])
                continue

            # 3. Anel circular do corpo do 'a'
            dx_body = x - body_cx
            dy_body = y - body_cy
            dist_sq = dx_body * dx_body + dy_body * dy_body
            if r_inner_sq <= dist_sq <= r_outer_sq:
                row.extend([cream_r, cream_g, cream_b, 255])
                continue

            # Fundo #141414
            row.extend([bg_r, bg_g, bg_b, 255])

        raw_rows.append(bytes(row))

    raw_data = b"".join(raw_rows)
    compressed = zlib.compress(raw_data, level=6)

    def chunk(tag, data):
        return (
            struct.pack(">I", len(data))
            + tag
            + data
            + struct.pack(">I", zlib.crc32(tag + data) & 0xFFFFFFFF)
        )

    ihdr = struct.pack(">IIBBBBB", width, height, 8, 6, 0, 0, 0)
    png = b"\x89PNG\r\n\x1a\n" + chunk(b"IHDR", ihdr) + chunk(b"IDAT", compressed) + chunk(b"IEND", b"")

    with open(filename, "wb") as f:
        f.write(png)
    print(f"Gerado ícone com sucesso em: {filename}")

if __name__ == "__main__":
    create_acorde_icon()
