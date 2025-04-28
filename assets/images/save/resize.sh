mkdir -p webp_out
for img in *.png; do
  filename=$(basename "$img")
  cwebp -resize 1920 0 -q 85 "$img" -o "${filename%.*}.webp"
done
