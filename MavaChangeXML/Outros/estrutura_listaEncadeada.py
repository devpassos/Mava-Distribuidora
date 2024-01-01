class Node:
    def __init__(self, data):
        self.data = data
        self.next = None

class LinkedList:
    def __init__(self):
        self.head = None
        self._size = 0

    def append(self, elem):
        if self.head:
            pointer = self.head
            while (pointer.next):
                pointer = pointer.next
            pointer.next = Node(elem)
        else:
            self.head = Node(elem)
        self._size += 1
        
    def __len__(self):
        return self._size

    def __setitem__(self, index, elem):
        pointer = self.head
        for i in range(index):
            if pointer:
                pointer = pointer.next
            else:
                raise IndexError("List Index Out of Range")
        if pointer:
             pointer.data = elem
        else:
            raise IndexError("List Index Out Of Range")  

    def __getitem__(self, index):
        pointer = self.head
        for i in range(index):
            if pointer:
                pointer = pointer.next
            else:
                raise IndexError("List Index Out of Range")
        if pointer:
             return pointer.data

        raise IndexError("List Index Out Of Range")   

    def index(self, elem):
        pointer = self.head
        i = 0
        while (pointer):
            if pointer.data == elem:
                return i
            
            pointer = pointer.next
            i += 1
        raise ValueError('{} is not in the list'.format(elem))


lista = LinkedList()

for j in range(1, 11):
    lista.append(j)

print(lista.index(8))



