import cv2

# Load an color image
img = cv2.imread('lenna.png')

# Show the image
cv2.imshow('image',img)

# Stop when 0 pressed
cv2.waitKey(0)
cv2.destroyAllWindows()