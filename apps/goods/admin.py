# -*- coding: utf-8 -*-
from __future__ import unicode_literals
from goods.models import GoodsType, IndexPromotionBanner, IndexGoodsBanner, IndexTypeGoodsBanner, GoodsSKU, Goods, \
    GoodsImage
from django.contrib import admin
from django.core.cache import cache


# Register your models here.

class BaseModelAdmin(admin.ModelAdmin):
    def save_model(self, request, obj, form, change):
        '''新增或修改表中的数据时调用'''
        super().save_model(request, obj, form, change)

        # 使用celery
        # 发出任务,让celery worker重新生成首页
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()

        # 更新缓存(清除首页缓存数据,当有新用户进入,会重新放入缓存)
        cache.delete('index_page_data')

    def delete_model(self, request, obj):
        '''删除表中数据调用'''
        super().delete_model(request, obj)

        # 使用celery
        # 发出任务,让celery worker重新生成首页
        from celery_tasks.tasks import generate_static_index_html
        generate_static_index_html.delay()


class IndexGoodsBannerAdmin(BaseModelAdmin):
    pass


class IndexTypeGoodsBannerAdmin(BaseModelAdmin):
    pass


class GoodsTypeAdmin(BaseModelAdmin):
    pass


class IndexPromotionBannerAdmin(BaseModelAdmin):
    list_display = ['name', 'url', 'image', 'index']


class GoodsAdmin(admin.ModelAdmin):
    list_display = ['name', 'detail']


class GoodsImageAdmin(admin.ModelAdmin):
    list_display = ['image', 'sku']


class GoodsSKUAdmin(admin.ModelAdmin):
    list_display = ['type', 'goods', 'name', 'desc', 'price', 'unite', 'image', 'stock', 'sales', 'status',
                    'status_choices']


admin.site.register(GoodsType, GoodsTypeAdmin)
admin.site.register(IndexGoodsBanner, IndexGoodsBannerAdmin)
admin.site.register(IndexTypeGoodsBanner, IndexTypeGoodsBannerAdmin)
admin.site.register(IndexPromotionBanner, IndexPromotionBannerAdmin)
admin.site.register(Goods, GoodsAdmin)
admin.site.register(GoodsImage, GoodsImageAdmin)
admin.site.register(GoodsSKU, GoodsSKUAdmin)
