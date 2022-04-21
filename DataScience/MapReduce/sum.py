# This is to test my understanding of map reduce on sorting
# Question: Design Mint.com
# URL: https://github.com/donnemartin/system-design-primer/blob/master/solutions/system_design/mint/README.md

from mrjob.job import MRJob
from datetime import datetime

class Categorizer:
    def __init__(self):
        """
        Initialize the categorizer.
        """
        self.categories = {
            "XXX Property": "HOUSING",
            "Tesco": "FOOD",
            "Scottish power": "GAS",
            "ToyRUs": "SHOPPING",
            "H&M": "SHOPPING",
        }
    
    def categorize(self, seller):
        return self.categories.get(seller, "OTHER")

class SpendingByCategory(MRJob):
    def __init__(self, *args, **kwargs):
        
        self.categorizer = Categorizer()
        self.current_year_month = self.calc_current_year_month()
        super().__init__(*args, **kwargs)

    def calc_current_year_month(self):
        _curtime = datetime.now()
        result = _curtime.strftime("%Y-%m")
        #print(result)
        return _curtime.strftime("%Y-%m")

    def extract_year_month(self, timestamp):
        """Return the year and month portions of the timestamp."""
        result = datetime.strptime(timestamp, '%Y-%m-%d %H:%M:%S').strftime('%Y-%m')
        #print(result)
        return result

    def mapper(self, _, line):
        """Parse each log line, extract and transform relevant lines.

        Argument line will be of the form:

        user_id   timestamp   seller  amount

        Using the categorizer to convert seller to category,
        emit key value pairs of the form:

        (user_id, 2016-01, shopping), 25
        (user_id, 2016-01, shopping), 100
        (user_id, 2016-01, gas), 50
        """
        user_id, timestamp, seller, amount = line.split('\t')
        category = self.categorizer.categorize(seller)
        period = self.extract_year_month(timestamp)
        if period == self.current_year_month:
            yield (user_id, period, category), int(amount)

    def reducer(self, key, value):
        """Sum values for each key.

        (user_id, 2016-01, shopping), 125
        (user_id, 2016-01, gas), 50
        """
        total = sum(value)
        yield key, total


if __name__ == '__main__':
    SpendingByCategory.run()