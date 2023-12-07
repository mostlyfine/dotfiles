#!/usr/bin/env python3
"""
Module Docstring
"""

import sys
from logging import getLogger, DEBUG, basicConfig

basicConfig(level=DEBUG, format='%(asctime)s %(levelname)s %(message)s')
logger = getLogger(__name__)


class TestClass:
    __message: str

    def __init__(self, name: str = 'world') -> None:
        self.__message = f'hello {name}'

    def main(self) -> None:
        logger.info(self.get_message())

    def get_message(self) -> str:
        return self.__message


if __name__ == "__main__":
    if len(sys.argv) > 1:
        test = TestClass(sys.argv[1])
    else:
        test = TestClass()

    try:
        print(test.__message)
    except Exception as e:
        logger.error(e)
        test.main()
