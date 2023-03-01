input_str = input("Enter a string: ")
heap = bytearray(len(input_str))  # create a byte array of same size as input string

# Copy input string to heap
for i in range(len(input_str)):
    heap[i] = ord(input_str[i])

# Print heap
print(heap.decode("ascii"))
