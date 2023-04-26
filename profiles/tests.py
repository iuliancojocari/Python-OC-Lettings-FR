import pytest
from django.urls import reverse
from django.test import Client
from django.contrib.auth.models import User
from .models import Profile


@pytest.mark.django_db
def test_profiles_index():
    client = Client()
    response = client.get(reverse('profiles:index'))
    content = response.content.decode()
    expected_content = "<title>Profiles</title>"

    assert response.status_code == 200
    assert expected_content in content


@pytest.mark.django_db
def test_profiles_detail():
    client = Client()

    user = User.objects.create(
        username="usertest",
        password="pwd@12345",
        email="usertest@exemple.com"
    )

    Profile.objects.create(user=user, favorite_city="Paris")

    response = client.get(reverse('profiles:profile', args=["usertest"]))
    content = response.content.decode()
    expected_content = "<title>usertest</title>"

    assert response.status_code == 200
    assert expected_content in content
