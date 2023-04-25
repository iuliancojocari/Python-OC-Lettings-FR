from django.urls import reverse
from django.test import Client


def test_home_index():
    client = Client()
    response = client.get(reverse('home:index'))
    content = response.content.decode()
    expected_content = "<title>Holiday Homes</title>"

    assert response.status_code == 200
    assert expected_content in content
