import pytest
from django.urls import reverse
from django.test import Client
from .models import Letting, Address


@pytest.mark.django_db
def test_lettings_index():
    client = Client()
    response = client.get(reverse('lettings:index'))
    content = response.content.decode()
    expected_content = "<title>Lettings</title>"

    assert response.status_code == 200
    assert expected_content in content


@pytest.mark.django_db
def test_lettings_detail():
    client = Client()

    address = Address.objects.create(
        number=15,
        street="Avenue Guillemeteau",
        city="Paris",
        state="France",
        zip_code=75001,
        country_iso_code="FR"
    )

    Letting.objects.create(
        title="Test Title",
        address=address
    )

    response = client.get(reverse('lettings:letting', args=[1]))
    content = response.content.decode()
    expected_content = "<title>Test Title</title>"

    assert response.status_code == 200
    assert expected_content in content
