from python import Python


fn main() raises:
    let requests = Python.import_module("requests")

    let response = requests.get('https://cat-fact.herokuapp.com/facts/random')

    if response.status_code == 200:
        let fact = response.json()['text']
        print(fact)
    else:
        print('Failed to fetch cat fact')
