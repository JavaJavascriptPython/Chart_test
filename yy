Sure! Here are examples of three different load balancing algorithms: Round Robin, Hashing, and Weighted Round Robin.1. Round Robin AlgorithmThe round-robin algorithm distributes requests sequentially across a list of servers. Here's a simple implementation in Python:class RoundRobinLoadBalancer:
    def __init__(self, servers):
        self.servers = servers
        self.index = 0

    def get_next_server(self):
        server = self.servers[self.index]
        self.index = (self.index + 1) % len(self.servers)
        return server

# Example usage
servers = ['Server1', 'Server2', 'Server3', 'Server4']
load_balancer = RoundRobinLoadBalancer(servers)

# Simulate incoming requests
for _ in range(10):
    server = load_balancer.get_next_server()
    print(f"Request sent to: {server}")2. Hashing AlgorithmThe hashing algorithm uses a hash function to distribute requests based on certain keys (e.g., client IP address). This ensures that requests from the same client are consistently directed to the same server.import hashlib

class HashingLoadBalancer:
    def __init__(self, servers):
        self.servers = servers

    def get_server(self, client_ip):
        hash_value = int(hashlib.md5(client_ip.encode()).hexdigest(), 16)
        server_index = hash_value % len(self.servers)
        return self.servers[server_index]

# Example usage
servers = ['Server1', 'Server2', 'Server3', 'Server4']
load_balancer = HashingLoadBalancer(servers)

# Simulate incoming requests from different client IPs
client_ips = ['192.168.1.1', '192.168.1.2', '192.168.1.3', '192.168.1.4']
for ip in client_ips:
    server = load_balancer.get_server(ip)
    print(f"Request from {ip} sent to: {server}")3. Weighted Round Robin AlgorithmThe weighted round-robin algorithm assigns weights to servers based on their capacity. Servers with higher weights receive more requests.class WeightedRoundRobinLoadBalancer:
    def __init__(self, servers, weights):
        self.servers = servers
        self.weights = weights
        self.index = 0
        self.current_weight = 0
        self.max_weight = max(weights)
        self.gcd_weight = self._gcd_of_weights(weights)

    def _gcd_of_weights(self, weights):
        from math import gcd
        from functools import reduce
        return reduce(gcd, weights)

    def get_next_server(self):
        while True:
            self.index = (self.index + 1) % len(self.servers)
            if self.index == 0:
                self.current_weight = self.current_weight - self.gcd_weight
                if self.current_weight <= 0:
                    self.current_weight = self.max_weight
                    if self.current_weight == 0:
                        return None
            if self.weights[self.index] >= self.current_weight:
                return self.servers[self.index]

# Example usage
servers = ['Server1', 'Server2', 'Server3']
weights = [5, 1, 1]  # Server1 has a weight of 5, Server2 and Server3 have a weight of 1
load_balancer = WeightedRoundRobinLoadBalancer(servers, weights)

# Simulate incoming requests
for _ in range(10):
    server = load_balancer.get_next_server()
    print(f"Request sent to: {server}")Explanation of Weighted Round RobinInitialization:servers is a list of servers.weights is a list of integers representing the weights for each server.index is the current server index.current_weight starts at 0 and will be adjusted as we iterate through the servers.max_weight is the highest weight among the servers.gcd_weight is the greatest common divisor of all weights, used to optimize the weight decrementing process.Get Next Server:Increment the index and wrap around if necessary.Adjust the current weight if we’ve cycled through all servers.Return the server if its weight is greater than or equal to the current weight.These examples provide basic implementations of the three different load balancing algorithms, which you can customize further based on your specific requirements.