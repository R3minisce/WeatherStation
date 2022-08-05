from .device import device_bp

def init_app(app):
    app.register_blueprint(device_bp)
