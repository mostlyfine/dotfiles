#!/usr/bin/env python3
"""
Module Docstring
"""

from logging import getLogger, DEBUG, basicConfig

basicConfig(level=DEBUG, format='%(asctime)s %(levelname)s %(message)s')
logger = getLogger(__name__)

class TestClass:
    def __init__(self, msg='hello world'):
        self.message = msg

    def main(self):
        logger.info(self.message)


if __name__ == "__main__":
    test = TestClass()
    test.main()
