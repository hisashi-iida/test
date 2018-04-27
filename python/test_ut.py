import unittest


def just_do_it(text):
    return text


class TestCap(unittest.TestCase):

    def setUp(self):
        pass

    def tearDown(self):
        pass

    def test_1(self):
        text = 'duck'
        result = just_do_it(text)
        self.assertEqual(result, 'duck')

    def test_2(self):
        text = 'ducks'
        result= just_do_it(text)
        self.assertEqual(result, 'Duck')


if __name__ == '__main__':
    unittest.main()
