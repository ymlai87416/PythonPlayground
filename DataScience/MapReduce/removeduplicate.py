# This is to test my understanding of map reduce on sorting
# Question: Design a web crawler
# URL: https://github.com/donnemartin/system-design-primer/blob/master/solutions/system_design/web_crawler/README.md

# The program seems have bugs...
# Seems like a count program

from mrjob.job import MRJob

class RemoveDuplicateUrls(MRJob):

    def mapper(self, _, line):
        yield line, 1

    def reducer(self, key, values):
        total = sum(values)
        yield key, total
            


if __name__ == '__main__':
    RemoveDuplicateUrls.run()