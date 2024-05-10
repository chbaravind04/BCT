import hashlib

class MerkleTree:
    def _init_(self, transactions):
        self.transactions = transactions
        self.root = self.build_merkle_tree(transactions)

    def build_merkle_tree(self, transactions):
        current_layer = list(transactions)

        while len(current_layer) > 1:
            new_layer = []

            for i in range(0, len(current_layer) - 1, 2):
                merged_hash = self.merge_hash(current_layer[i], current_layer[i + 1])
                new_layer.append(merged_hash)

            if len(current_layer) % 2 == 1:
                merged_hash = self.merge_hash(current_layer[-1], current_layer[-1])
                new_layer.append(merged_hash)

            current_layer = new_layer

        return current_layer[0]

    def merge_hash(self, hash1, hash2):
        merged_string = hash1 + hash2
        return self.apply_sha256(merged_string)

    def apply_sha256(self, input):
        return hashlib.sha256(input.encode()).hexdigest()

    def get_root(self):
        return self.root

def main():
    transactions = [
        "Transaction1",
        "Transaction2",
        "Transaction3",
        "Transaction4",
        "Transaction5",
        "Transaction6"
    ]

    merkle_tree = MerkleTree(transactions)
    print("Merkle Root:", merkle_tree.get_root())

if _name_ == "_main_":
    main()
