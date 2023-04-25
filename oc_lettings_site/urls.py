from django.contrib import admin
from django.urls import path, include


def trigger_error(request):
    division_by_zero = 1 / 0
    return division_by_zero


urlpatterns = [
    path('admin/', admin.site.urls),
    path('', include('profiles.urls')),
    path('', include('lettings.urls')),
    path('', include('home.urls')),
    path('sentry-debug/', trigger_error),
]
