test_cases = int(input())
for _ in range(test_cases):
    length = int(input())
    numbers = list(map(int, input().split()))

    numbers.sort()
    i , j = 0, length-1
    res = 0
    while i < length:
        res += numbers[i]
        if res == numbers[j]:
            
