# Carrierwave Swift Swauth

This gem is a [Carrierwave](https://github.com/jnicklas/carrierwave/) store for [OpenStack Swift](swift.openstack.org). This library uses [swauth](https://github.com/gholt/swauth) for authentication.

## Installation

```
gem install carrierwave-swift-swauth
```

## Usage

You should specify the following variables in your environment. We don't like storing passwords in the plain.

```
export SWIFT_USER="user"
export SWIFT_PASSWORD="some-secret-password"
export SWIFT_URL="https://your-swift-server.com"
export SWIFT_TENANT="tenant-name"
export SWIFT_CONTAINER="container-name"
```

Set the storage to be __swift_swauth__. The usual Paperclip configuration should be applicable.

``` ruby
class AvatarUploader < CarrierWave::Uploader::Base
  :storage => :swift_swauth
end
```

## License

Apache 2.0. See LICENSE for details.
