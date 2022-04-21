# This is to test my understanding of map reduce on sorting
# Question: Design Amazon's sales rank by category feature
# URL: https://github.com/donnemartin/system-design-primer/blob/master/solutions/system_design/sales_rank/README.md

from mrjob.job import MRJob
from mrjob.step import MRStep
import sys
class SalesRanker(MRJob):

    def within_past_week(self, timestamp):
        """Return True if timestamp is within past week, False otherwise."""
        return True

    def mapper(self, _, line):
        """Parse each log line, extract and transform relevant lines.

        Emit key value pairs of the form:

        (category1, product1), 2
        (category2, product1), 2
        (category2, product1), 1
        (category1, product2), 3
        (category2, product3), 7
        (category1, product4), 1
        """
        timestamp, product_id, category_id, quantity, total_price, seller_id, \
            buyer_id = line.split('\t')
        #sys.stdout.write(product_id.encode('utf-8'))

        if self.within_past_week(timestamp):
            yield (category_id, product_id), int(quantity)

    def reducer(self, key, value):
        """Sum values for each key.

        (category1, product1), 2
        (category2, product1), 3
        (category1, product2), 3
        (category2, product3), 7
        (category1, product4), 1
        """
        yield key, sum(value)

    def mapper_sort(self, key, value):
        """Construct key to ensure proper sorting.

        Transform key and value to the form:

        (category1, 2), product1
        (category2, 3), product1
        (category1, 3), product2
        (category2, 7), product3
        (category1, 1), product4

        The shuffle/sort step of MapReduce will then do a
        distributed sort on the keys, resulting in:

        (category1, 1), product4
        (category1, 2), product1
        (category1, 3), product2
        (category2, 3), product1
        (category2, 7), product3
        """
        category_id, product_id = key
        quantity = str(value)
        yield (category_id, quantity), product_id

    def reducer_identity(self, key, values):
        d = [v for v in values]
        for dd in d:
            yield key, dd

    def steps(self):
        """Run the map and reduce steps."""
        return [
            MRStep(mapper=self.mapper,
                    reducer=self.reducer),
            MRStep(mapper=self.mapper_sort,
                    reducer=self.reducer_identity),
        ]


if __name__ == '__main__':
    SalesRanker.run()