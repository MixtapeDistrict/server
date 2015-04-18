# Be sure to restart your server when you modify this file.

WebInfo2::Application.config.session_store :cookie_store, key: '_WebInfo2_session',
    :key => '_my_session', 
    :expire_after => 30.minutes