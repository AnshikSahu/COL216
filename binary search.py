# Iterative binary search in Python

# Prompt for array length and read n
n = int(input("Enter the length of the array: "))

# Prompt for array elements and read arr
arr = []
for i in range(n):
    element = int(input("Enter the element: "))
    arr.append(element)

# Prompt for key and read key
key = int(input("Enter the key to search: "))

# Perform binary search on the array
left = 0
right = n - 1
found = False

while left <= right:
    middle = (left + right) // 2
    if arr[middle] == key:
        print("Yes at index", middle)
        found = True
        break
    elif arr[middle] < key:
        left = middle + 1
    else:
        right = middle - 1

if not found:
    print("Not found")
