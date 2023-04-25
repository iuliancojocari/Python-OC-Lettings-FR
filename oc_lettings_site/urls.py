from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('', include('home.urls')),
    path('', include('lettings.urls'), name='lettings'),
    path('', include('profiles.urls'), name='profiles'),
    path('admin/', admin.site.urls),
]
