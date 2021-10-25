// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'PartnerDto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PartnerDto _$PartnerDtoFromJson(Map<String, dynamic> json) => PartnerDto(
      id: json['id'] as String?,
      partnerName: json['partnerName'] as String?,
      country: json['country'] as String?,
      domestic: json['domestic'] as bool?,
      address: json['address'] as String?,
      city: json['city'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$PartnerDtoToJson(PartnerDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'partnerName': instance.partnerName,
      'country': instance.country,
      'domestic': instance.domestic,
      'address': instance.address,
      'city': instance.city,
      'email': instance.email,
      'phone': instance.phone,
    };
