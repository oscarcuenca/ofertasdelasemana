{*
* 2007-2014 PrestaShop
*
* NOTICE OF LICENSE
*
* This source file is subject to the Academic Free License (AFL 3.0)
* that is bundled with this package in the file LICENSE.txt.
* It is also available through the world-wide-web at this URL:
* http://opensource.org/licenses/afl-3.0.php
* If you did not receive a copy of the license and are unable to
* obtain it through the world-wide-web, please send an email
* to license@prestashop.com so we can send you a copy immediately.
*
* DISCLAIMER
*
* Do not edit or add to this file if you wish to upgrade PrestaShop to newer
* versions in the future. If you wish to customize PrestaShop for your
* needs please refer to http://www.prestashop.com for more information.
*
*  @author PrestaShop SA <contact@prestashop.com>
*  @copyright  2007-2014 PrestaShop SA
*  @license    http://opensource.org/licenses/afl-3.0.php  Academic Free License (AFL 3.0)
*  International Registered Trademark & Property of PrestaShop SA
*}
{include file="$tpl_dir./errors.tpl"}
{if $errors|@count == 0}
        {if !isset($priceDisplayPrecision)}
                {assign var='priceDisplayPrecision' value=2}
        {/if}
        {if !$priceDisplay || $priceDisplay == 2}
                {assign var='productPrice' value=$product->getPrice(true, $smarty.const.NULL, $priceDisplayPrecision)}
                {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(false, $smarty.const.NULL)}
        {elseif $priceDisplay == 1}
                {assign var='productPrice' value=$product->getPrice(false, $smarty.const.NULL, $priceDisplayPrecision)}
                {assign var='productPriceWithoutReduction' value=$product->getPriceWithoutReduct(true, $smarty.const.NULL)}
        {/if}
<div itemscope itemtype="http://schema.org/Product">
        <div class="row content_only_row">
        <div class="col-md-12 main_product">
        <div class="primary_block">
                {if isset($adminActionDisplay) && $adminActionDisplay}
                        <div id="admin-action">
                                <p>{l s='This product is not visible to your customers.'}
                                        <input type="hidden" id="admin-action-product-id" value="{$product->id}" />
                                        <input type="submit" value="{l s='Publish'}" name="publish_button" class="exclusive" />
                                        <input type="submit" value="{l s='Back'}" name="lnk_view" class="exclusive" />
                                </p>
                                <p id="admin-action-result"></p>
                        </div>
                {/if}
                {if isset($confirmation) && $confirmation}
                        <p class="confirmation">
                                {$confirmation}
                        </p>
                {/if}


                <div id="product_view_primary_block" class="primary_block row-img row">
                        <!-- left infos-->
                        {if !isset($content_only) || !$content_only}
                        <div class="product-img-box col-sm-5">
                        {else}
                        <div class="product-img-box col-xs-5">
                        {/if}
                                <!-- product img-->
                                <div id="image-block" class="clearfix">
                                        <div class="badges">
                                                {if $product->new}<span class="ico-product ico-new"><span class="ico-new">{l s='New'}</span></span>{/if}
                                                {if $product->on_sale}
                                                        <span class="ico-product ico-sale"><span class="ico-sale">{l s='Sale!'}</span></span>
                                                {elseif $product->specificPrice && $product->specificPrice.reduction && $productPriceWithoutReduction > $productPrice}
                                                        <span class="ico-product ico-sale"><span class="ico-sale">{l s='Reduced price!'}</span></span>
                                                {/if}
                                        </div>

                                        {if $have_image}
                                                <span id="view_full_size">
                                                        {if $jqZoomEnabled && $have_image && !$content_only}
                                                                <a class="jqzoom" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" rel="gal1" href="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'thickbox_default')|escape:'html':'UTF-8'}" itemprop="url">
                                                                        <img itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}"/>
                                                                </a>
                                                        {else}
                                                                {if isset($images)}
                                                                        {foreach from=$images item=image name=thumbnails}
                                                                                {if $image.cover}
                                                                                        {assign var=coverImgId value="`$product->id`-`$image.id_image`"}
                                                                                        {if !empty($image.legend)}
                                                                                                {assign var=coverImgTitle value=$image.legend|escape:'html':'UTF-8'}
                                                                                        {else}
                                                                                                {assign var=coverImgTitle value=$product->name|escape:'html':'UTF-8'}
                                                                                        {/if}
                                                                                {/if}
                                                                        {/foreach}
                                                                {/if}
                                                                {if isset($coverImgId) && $coverImgId}
                                                                        <img id="bigpic" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $coverImgId, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($coverImgTitle)}{$coverImgTitle|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($coverImgTitle)}{$coverImgTitle|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}"/>
                                                                {else}
                                                                        <img id="bigpic" itemprop="image" src="{$link->getImageLink($product->link_rewrite, $cover.id_image, 'large_default')|escape:'html':'UTF-8'}" title="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" alt="{if !empty($cover.legend)}{$cover.legend|escape:'html':'UTF-8'}{else}{$product->name|escape:'html':'UTF-8'}{/if}" width="{$largeSize.width}" height="{$largeSize.height}"/>
                                                                {/if}

                                                                {if !$content_only}
                                                                        <span class="span_link no-print">{l s='View larger'}</span>
                                                                {/if}
                                                        {/if}
                                                </span>
                                        {else}
                                                <span id="view_full_size">
                                                        <img itemprop="image" src="{$img_prod_dir}{$lang_iso}-default-large_default.jpg" id="bigpic" alt="" title="{$product->name|escape:'html':'UTF-8'}" width="{$largeSize.width}" height="{$largeSize.height}"/>
                                                        {if !$content_only}
                                                                <span class="span_link">
                                                                        {l s='View larger'}
                                                                </span>
                                                        {/if}
                                                </span>
                                        {/if}
                                </div> <!-- end image-block -->
                                {if isset($images) && count($images) > 0}

                                        <!-- thumbnails -->

                                        <div id="views_block" class="clearfix {if isset($images) && count($images) < 2}hidden{/if}">

                                                {if isset($images) && count($images) > 2}
                                                        <a id="view_scroll_left" class="" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
                                                                {l s='Previous'}
                                                        </a>

                                                {/if}

                                                <div id="thumbs_list">
                                                        <ul id="thumbs_list_frame">
                                                        {if isset($images)}
                                                                {foreach from=$images item=image name=thumbnails}
                                                                        {assign var=imageIds value="`$product->id`-`$image.id_image`"}
                                                                        {if !empty($image.legend)}
                                                                                {assign var=imageTitle value=$image.legend|escape:'html':'UTF-8'}
                                                                        {else}
                                                                                {assign var=imageTitle value=$product->name|escape:'html':'UTF-8'}
                                                                        {/if}
                                                                        <li id="thumbnail_{$image.id_image}"{if $smarty.foreach.thumbnails.last} class="last"{/if}>
                                                                                <a{if $jqZoomEnabled && $have_image && !$content_only} href="javascript:void(0);" rel="{literal}{{/literal}gallery: 'gal1', smallimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'large_default')|escape:'html':'UTF-8'}',largeimage: '{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}'{literal}}{/literal}"{else} href="{$link->getImageLink($product->link_rewrite, $imageIds, 'thickbox_default')|escape:'html':'UTF-8'}" data-fancybox-group="other-views" class="fancybox{if $image.id_image == $cover.id_image} shown{/if}"{/if} title="{$imageTitle}">
                                                                                        <img class="img-responsive" id="thumb_{$image.id_image}" src="{$link->getImageLink($product->link_rewrite, $imageIds, 'small_default')|escape:'html':'UTF-8'}" alt="{$imageTitle}" title="{$imageTitle}" height="{$cartSize.height}" width="{$cartSize.width}" itemprop="image" />
                                                                                </a>
                                                                        </li>
                                                                {/foreach}
                                                        {/if}
                                                        </ul>
                                                </div> <!-- end thumbs_list -->

                                                {if isset($images) && count($images) > 2}
                                                        <a id="view_scroll_right" title="{l s='Other views'}" href="javascript:{ldelim}{rdelim}">
                                                                {l s='Next'}
                                                        </a>
                                                {/if}

                                        </div> <!-- end views-block -->
                                <!-- end thumbnails -->


                                {/if}
                                {if isset($images) && count($images) > 1}
                                        <div class="resetimg clear no-print">
                                                <span id="wrapResetImages" style="display: none;">
                                                        <a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" name="resetImages">
                                                                <i class="fa fa-repeat"></i>
                                                                {l s='Display all pictures'}
                                                        </a>
                                                </span>
                                        </div>
                                {/if}



                        </div> <!-- end pb-left-column -->
                        <!-- end left infos-->
                        <!-- center infos -->
                        {if !isset($content_only) || !$content_only}
                        <div class="product-shop col-sm-5">
                        {else}
                        <div class="product-shop col-xs-5">
                        {/if}
                                <form id="buy_block"{if $PS_CATALOG_MODE && !isset($groups) && $product->quantity > 0} class="hidden"{/if} action="{$link->getPageLink('cart')|escape:'html':'UTF-8'}" method="post">
                                        <input type="hidden" name="token" value="{$static_token}" />
                                        <input type="hidden" name="id_product" value="{$product->id|intval}" id="product_page_product_id" />
                                        <input type="hidden" name="add" value="1" />
                                        <input type="hidden" name="id_product_attribute" id="idCombination" value="" />

                                        {if $product->online_only}
                                                <p class="online_only">{l s='Online only'}</p>
                                        {/if}
                                        <div class="product-name" itemprop="name">{$product->name|escape:'html':'UTF-8'}</div>


                                        <!-- review -->
                                        <div class="ratings-block">{if isset($HOOK_EXTRA_RIGHT) && $HOOK_EXTRA_RIGHT}{$HOOK_EXTRA_RIGHT}{/if}</div>
                                        {hook h='ekomiReviewsContainer' mod=ekomiratingsandreviews product=$product}
                    {hook h='ekomiReviewStars' mod=ekomiratingsandreviews product=$product}


                                        <!-- price -->
                                        <div class="price-box">
                                                {if $product->show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
                                                        <!-- prices -->
                                                        <div class="price">
                                                                <p class="our_price_display" itemprop="offers" itemscope itemtype="http://schema.org/Offer">
                                                                        {if $product->quantity > 0}<link itemprop="availability" href="http://schema.org/InStock"/>{/if}
                                                                        {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                                                <span id="our_price_display" itemprop="price">{convertPrice price=$productPrice}</span>
                                                                                <!--{if $tax_enabled  && ((isset($display_tax_label) && $display_tax_label == 1) || !isset($display_tax_label))}
                                                                                        {if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}
                                                                                {/if}-->
                                                                                <meta itemprop="priceCurrency" content="{$currency->iso_code}" />
                                                                                {hook h="displayProductPriceBlock" product=$product type="price"}
                                                                        {/if}
                                                                </p>
                                                        <!--
                                                                <p id="reduction_percent" {if !$product->specificPrice || $product->specificPrice.reduction_type != 'percentage'} style="display:none;"{/if}>
                                                                        <span id="reduction_percent_display">
                                                                                {if $product->specificPrice && $product->specificPrice.reduction_type == 'percentage'}-{$product->specificPrice.reduction*100}%{/if}
                                                                        </span>
                                                                </p>

                                                                <p id="reduction_amount" {if !$product->specificPrice || $product->specificPrice.reduction_type != 'amount' || $product->specificPrice.reduction|floatval ==0} style="display:none"{/if}>
                                                                        <span id="reduction_amount_display">
                                                                        {if $product->specificPrice && $product->specificPrice.reduction_type == 'amount' && $product->specificPrice.reduction|floatval !=0}
                                                                                -{convertPrice price=$productPriceWithoutReduction-$productPrice|floatval}
                                                                        {/if}
                                                                        </span>
                                                                </p>
                                                        -->
                                                                <p id="old_price"{if (!$product->specificPrice || !$product->specificPrice.reduction) && $group_reduction == 0} class="hidden"{/if}>
                                                                        {if $priceDisplay >= 0 && $priceDisplay <= 2}
                                                                                {hook h="displayProductPriceBlock" product=$product type="old_price"}
                                                                                <span id="old_price_display">{if $productPriceWithoutReduction > $productPrice}{convertPrice price=$productPriceWithoutReduction}{/if}</span>
                                                                                <!-- {if $tax_enabled && $display_tax_label == 1}{if $priceDisplay == 1}{l s='tax excl.'}{else}{l s='tax incl.'}{/if}{/if} -->
                                                                        {/if}
                                                                </p>
                                                                {if $priceDisplay == 2}
                                                                        <br />
                                                                        <span id="pretaxe_price">
                                                                                <span id="pretaxe_price_display">{convertPrice price=$product->getPrice(false, $smarty.const.NULL)}</span>
                                                                                {l s='tax excl.'}
                                                                        </span>
                                                                {/if}
                                                        </div> <!-- end prices -->
                                                        {if $packItems|@count && $productPrice < $product->getNoPackPrice()}
                                                                <p class="pack_price">{l s='Instead of'} <span style="text-decoration: line-through;">{convertPrice price=$product->getNoPackPrice()}</span></p>
                                                        {/if}
                                                        {if $product->ecotax != 0}
                                                                <p class="price-ecotax">{l s='Including'} <span id="ecotax_price_display">{if $priceDisplay == 2}{$ecotax_tax_exc|convertAndFormatPrice}{else}{$ecotax_tax_inc|convertAndFormatPrice}{/if}</span> {l s='for ecotax'}
                                                                        {if $product->specificPrice && $product->specificPrice.reduction}
                                                                        <br />{l s='(not impacted by the discount)'}
                                                                        {/if}
                                                                </p>
                                                        {/if}
                                                        {if !empty($product->unity) && $product->unit_price_ratio > 0.000000}
                                                                {math equation="pprice / punit_price"  pprice=$productPrice  punit_price=$product->unit_price_ratio assign=unit_price}
                                                                <p class="unit-price"><span id="unit_price_display">{convertPrice price=$unit_price}</span> {l s='per'} {$product->unity|escape:'html':'UTF-8'}</p>
                                                                {hook h="displayProductPriceBlock" product=$product type="unit_price"}
                                                        {/if}
                                                {/if} {*close if for show price*}
                                                {hook h="displayProductPriceBlock" product=$product type="weight"}
                                        </div> <!-- end content_prices -->




                                        <!-- availability -->
                                        <div class="availability">

                                                {if ($display_qties == 1 && !$PS_CATALOG_MODE && $PS_STOCK_MANAGEMENT && $product->available_for_order)}
                                                        <!-- number of item in stock -->

                                                        <p id="pQuantityAvailable"{if $product->quantity <= 0} style="display: none;"{/if}>
                                                                <span <p>stock =
                                                                <span id="quantityAvailable">{$product->quantity|intval}</span>
                                                                <span {if $product->quantity > 1} style="display: none;"{/if} id="quantityAvailableTxt">{l s='Item'},</span>
                                                                <span {if $product->quantity == 1} style="display: none;"{/if} id="quantityAvailableTxtMultiple">{l s='Items'}</span>
                                                        </p>

                                                {/if}

                                                {if $PS_STOCK_MANAGEMENT}
                                                        <!-- availability -->
                                                        <!-- <label>{l s=' Availability'}</label> -->
                                                        <p id="availability_statut"{if ($product->quantity <= 0 && !$product->available_later && $allow_oosp) || ($product->quantity > 0 && !$product->available_now) || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
                                                                {*<span id="availability_label">{l s='Availability:'}</span>*}
                                                                <span id="availability_value"{if $product->quantity <= 0 && !$allow_oosp} class="warning_inline"{/if}>{if $product->quantity <= 0}{if $allow_oosp}{$product->available_later}{else}Producto bajo pedido: solicitar pedido a <a href="mailto:info@tienda-first.com">info@tienda-first.com</a>{/if}{else}{$product->available_now}{/if}</span>
                                                        </p>
                                                        {hook h="displayProductDeliveryTime" product=$product}
                                                        <p class="warning_inline" id="last_quantities"{if ($product->quantity > $last_qties || $product->quantity <= 0) || $allow_oosp || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none"{/if} >{l s='Warning: Last items in stock!'}</p>
                                                {/if}
                                                <p id="availability_date"{if ($product->quantity > 0) || !$product->available_for_order || $PS_CATALOG_MODE || !isset($product->available_date) || $product->available_date < $smarty.now|date_format:'%Y-%m-%d'} style="display: none;"{/if}>
                                                        <span id="availability_date_label">{l s='Availability date:'}</span>
                                                        <span id="availability_date_value">{dateFormat date=$product->available_date full=false}</span>
                                                </p>
                                                <!-- Out of stock hook -->
                                                <div id="oosHook"{if $product->quantity > 0} style="display: none;"{/if}>
                                                        {$HOOK_PRODUCT_OOS}
                                                </div>
                                        </div>

                                        <div id="product_reference" class="prd-reference"{if empty($product->reference) || !$product->reference} style="display: none;"{/if}>
                                                <label>{l s='Model'} </label>
                                                <span class="editable" itemprop="sku">{if !isset($groups)}{$product->reference|escape:'html':'UTF-8'}{/if}</span>
                                        </div>
                                        {if $product->condition}
                                        <div id="product_condition" class="prd-condition">
                                                <label>{l s='Condition'} </label>
                                                {if $product->condition == 'new'}
                                                        <link itemprop="itemCondition" href="http://schema.org/NewCondition"/>
                                                        <span class="editable">{l s='New'}</span> <p> plazo de entrega: 4-5 días para productos en stock</p>
                                                        <p>Garantía oficial del fabricante : 2 años</p>



                                                {elseif $product->condition == 'used'}

                                                        <link itemprop="itemCondition" href="http://schema.org/UsedCondition"/>
                                                        <span class="editable">{l s='Used'}</span>
                                                {elseif $product->condition == 'refurbished'}
                                                        <link itemprop="itemCondition" href="http://schema.org/RefurbishedCondition"/>
                                                        <span class="editable">{l s='Refurbished'}</span>
                                                {/if}
                                        </div>
                                        {/if}





                                                {if mb_strlen($product->description_short) > 40}
                                                <div id="short_description_block" class="short-description">

                                                                <div id="short_description_content" itemprop="description">{$product->description_short}</div>

                                                        <!--{if $packItems|@count > 0}
                                                                <div class="short_description_pack">
                                                                <h3>{l s='Pack content'}</h3>
                                                                        {foreach from=$packItems item=packItem}

                                                                        <div class="pack_content">
                                                                                {$packItem.pack_quantity} x <a href="{$link->getProductLink($packItem.id_product, $packItem.link_rewrite, $packItem.category)|escape:'html':'UTF-8'}">{$packItem.name|escape:'html':'UTF-8'}</a>
                                                                                <p>{$packItem.description_short}</p>
                                                                        </div>
                                                                        {/foreach}
                                                                </div>
                                                        {/if}-->
                                                </div> {/if} <!-- end short_description_block -->


                                        <!-- pb-right-column-->
                                                {if ($product->show_price && !isset($restricted_country_mode)) || isset($groups) || $product->reference || (isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS)}
                                                <!-- add to cart form-->
                                                {if isset($groups)}
                                                        <div class="product_attributes clearfix">

                                                                        <!-- attributes -->
                                                                        <div id="attributes">
                                                                                <div class="clearfix"></div>
                                                                                {foreach from=$groups key=id_attribute_group item=group}
                                                                                        {if $group.attributes|@count}
                                                                                                <fieldset class="attribute_fieldset">
                                                                                                        <label class="attribute_label" {if $group.group_type != 'color' && $group.group_type != 'radio'}for="group_{$id_attribute_group|intval}"{/if}>{$group.name|escape:'html':'UTF-8'}&nbsp;</label>
                                                                                                        {assign var="groupName" value="group_$id_attribute_group"}
                                                                                                        <div class="attribute_list">
                                                                                                                {if ($group.group_type == 'select')}
                                                                                                                        <select name="{$groupName}" id="group_{$id_attribute_group|intval}" class="form-control attribute_select no-print">
                                                                                                                                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                                                                                        <option value="{$id_attribute|intval}"{if (isset($smarty.get.$groupName) && $smarty.get.$groupName|intval == $id_attribute) || $group.default == $id_attribute} selected="selected"{/if} title="{$group_attribute|escape:'html':'UTF-8'}">{$group_attribute|escape:'html':'UTF-8'}</option>
                                                                                                                                {/foreach}
                                                                                                                        </select>



                                                                                                                {elseif ($group.group_type == 'color')}
                                                                                                                        <ul id="color_to_pick_list" class="clearfix">
                                                                                                                                {assign var="default_colorpicker" value=""}
                                                                                                                                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                                                                                        {assign var='img_color_exists' value=file_exists($col_img_dir|cat:$id_attribute|cat:'.jpg')}
                                                                                                                                        <li{if $group.default == $id_attribute} class="selected"{/if}>
                                                                                                                                                <a href="{$link->getProductLink($product)|escape:'html':'UTF-8'}" id="color_{$id_attribute|intval}" name="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" class="color_pick{if ($group.default == $id_attribute)} selected{/if}"{if !$img_color_exists && isset($colors.$id_attribute.value) && $colors.$id_attribute.value} style="background:{$colors.$id_attribute.value|escape:'html':'UTF-8'};"{/if} title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}">
                                                                                                                                                        {if $img_color_exists}
                                                                                                                                                                <img src="{$img_col_dir}{$id_attribute|intval}.jpg" alt="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" title="{$colors.$id_attribute.name|escape:'html':'UTF-8'}" width="20" height="20" />
                                                                                                                                                        {/if}
                                                                                                                                                </a>
                                                                                                                                        </li>
                                                                                                                                        {if ($group.default == $id_attribute)}
                                                                                                                                                {$default_colorpicker = $id_attribute}
                                                                                                                                        {/if}


                                                                                                                                {/foreach}
                                                                                                                        </ul>
                                                                                                                        <input type="hidden" class="color_pick_hidden" name="{$groupName|escape:'html':'UTF-8'}" value="{$default_colorpicker|intval}" />
                                                                                                                {elseif ($group.group_type == 'radio')}
                                                                                                                        <ul>
                                                                                                                                {foreach from=$group.attributes key=id_attribute item=group_attribute}
                                                                                                                                        <li>
                                                                                                                                                <input type="radio" class="attribute_radio" name="{$groupName|escape:'html':'UTF-8'}" value="{$id_attribute}" {if ($group.default == $id_attribute)} checked="checked"{/if} />
                                                                                                                                                <span>{$group_attribute|escape:'html':'UTF-8'}</span>
                                                                                                                                        </li>
                                                                                                                                {/foreach}
                                                                                                                        </ul>
                                                                                                                {/if}
                                                                                                        </div> <!-- end attribute_list -->
                                                                                                </fieldset>
                                                                                        {/if}
                                                                                {/foreach}
                                                                        </div> <!-- end attributes -->

                                                        </div> {/if}<!-- end product_attributes -->
                                                        <div class="addcart-action">
                                                                <!-- quantity wanted -->
                                                                {if !$PS_CATALOG_MODE}
                                                                <div id="quantity_wanted_p"{if (!$allow_oosp && $product->quantity <= 0) || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
                                                                        <div class="n-qty-label"><label>{l s='Qty'}</label></div>
                                                                        <div class="qty-input">
                                                                                <input type="text" name="qty" id="quantity_wanted" class="text" value="{if isset($quantityBackup)}{$quantityBackup|intval}{else}{if $product->minimal_quantity > 1}{$product->minimal_quantity}{else}1{/if}{/if}" /><!--
                                                                        --><a href="#" data-field-qty="qty" class="btn btn-default button-minus product_quantity_down"></a><!--
                                                                        --><a href="#" data-field-qty="qty" class="btn btn-default button-plus product_quantity_up"></a>
                                                                        </div>



                                                                </div>
                                                                {/if}

                                                                <div class="box-cart-bottom">
                                                                        <!--  Add to cart -->
                                                                        <p id="add_to_cart" class="buttons_bottom_block no-print >{if (!$allow_oosp && $product->quantity <= 0) || !$product->available_for_order || (isset($restricted_country_mode) && $restricted_country_mode) || $PS_CATALOG_MODE} unvisible{/if}">
                                                                                <button type="submit" name="Submit" class="exclusive btn">
                                                                                        <span>{if $content_only && (isset($product->customization_required) && $product->customization_required)}{l s='Customize'}{else}{l s='Add to cart'}{/if}</span>
                                                                                </button>
                                                                        </p>

                                                                        <!-- usefull links-->

                                                                </div> <!-- end box-cart-bottom -->




                                                                <!-- minimal quantity wanted -->
                                                                <p id="minimal_quantity_wanted_p"{if $product->minimal_quantity <= 1 || !$product->available_for_order || $PS_CATALOG_MODE} style="display: none;"{/if}>
                                                                        {l s='This product is not sold individually. You must select at least'} <b id="minimal_quantity_label">{$product->minimal_quantity}</b> {l s='quantity for this product.'}
                                                                </p>
                                                        </div>

                                                        {if $product->id_supplier != '3' && $product->id_supplier != '4'}

                                                        <!--<p><a title="Solicita llamada" href="http://www.123formbuilder.com/form-4320661/formulario-de-contacto-leads" target="_blank"><img src="https://tienda-first.com/img/solicitallamada.jpg" alt="Solicite llamada" /></a></p>-->
                                                                <span style="font-size: 18px" class="label label-primary"><p>Consulte dudas sobre este producto haciendo clic <a style="color: #fff" href="https://tienda-first.com/contactenos" ><strong><u>aquí</u></strong></p></a></span>
                                                                <p>14 días para devolución</p>
                                                                <p>Todos nuestros productos son oficiales del canal de distribución español, por lo que vienen con teclado en castellano con la letra Ñ y garantía nacional.</p>

                                                                {elseif $product->id_supplier == '3' || $product->id_supplier == '4'}
                                                                        <p style="color:#FD0004">Consulte dudas sobre este producto haciendo clic <a href="https://tienda-first.com/contactenos" ><strong><u>aquí</u></strong></p></a>
                                                                        <p style="color:#FD0004">14 días para devolución</p>
                                                        {/if}




                                                            <div id="widget-container" class="ekomi-widget-container ekomi-widget-sf1157805b30e381cf0a3"></div>



<script type="text/javascript">

    (function (w) {
        w['_ekomiWidgetsServerUrl'] = (document.location.protocol == 'https:' ? 'https:' : 'http:') + '//widgets.ekomi.com';
        w['_customerId'] = 115780;
        w['_ekomiDraftMode'] = true;
        w['_language'] = 'es';

        if(typeof(w['_ekomiWidgetTokens']) !== 'undefined'){
            w['_ekomiWidgetTokens'][w['_ekomiWidgetTokens'].length] = 'sf1157805b30e381cf0a3';
        } else {
            w['_ekomiWidgetTokens'] = new Array('sf1157805b30e381cf0a3');
        }

        if(typeof(ekomiWidgetJs) == 'undefined') {
            ekomiWidgetJs = true;

                        var scr = document.createElement('script');scr.src = 'https://sw-assets.ekomiapps.de/static_resources/widget.js';
            var head = document.getElementsByTagName('head')[0];head.appendChild(scr);
                    }
    })(window);
</script><p</p>



                                                        <ul id="usefull_link_block" class="clearfix no-print">
                                                                {if isset($HOOK_PRODUCT_ACTIONS) && $HOOK_PRODUCT_ACTIONS}{$HOOK_PRODUCT_ACTIONS}{/if}
                                                                {if isset($comparator_max_item) && $comparator_max_item}
                                                                        <li>
                                                                                <a class="add_to_compare" href="{$product->link_rewrite|escape:'html':'UTF-8'}" data-id-product="{$product->id}" title="{l s='Add to Compare'}"  >
                                                                                        <i class="fa fa-random"></i>
                                                                                        {l s='Add to Compare'}

                                                                                </a>
                                                                                <script>// <![CDATA[
$(document).on('ready ajaxComplete', function(){
                        $('.countdown').each(function(){
                                var enddate = $(this).attr('data-endtime');
                                if(enddate) {
                                var enddateArr = enddate.split(',');
                                $(this).countdown({
                                        until: new Date(enddateArr[0], enddateArr[1] - 1, enddateArr[2], enddateArr[3], enddateArr[4], enddateArr[5]),
                                        labels: ["{l s='Years'}", "{l s='Months'}", "{l s='Weeks'}", "{l s='Days'}", "{l s='Hrs'}", "{l s='Mins'}", "{l s='Secs'}"],
                                        labels1: ["{l s='Year'}", "{l s='Month'}", "{l s='Week'}", "{l s='Day'}", "{l s='Hr'}", "{l s='Min'}", "{l s='Sec'}"]
                                });
                                }
                        });
                });
// ]]></script>
                                                                        </li>
                                                                {/if}
                                                                {if $HOOK_EXTRA_LEFT}{$HOOK_EXTRA_LEFT}{/if}
                                                                <li class="print">
                                                                        <a href="javascript:print(); ">
                                                                                <i class="fa fa-print"></i>
                                                                                {l s='Print'}

                                                                        </a>
                                                                </li>
                                                                {if $have_image && !$jqZoomEnabled}{/if}
                                                        </ul>

                                                        {if $SNS_KTA_ADDTHISBTN}
                                                        <div class="block-addthis">
                                                <!-- AddThis Button BEGIN -->

                                                                <div class="addthis_native_toolbox"></div>
                                                                <script type="text/javascript" src="//s7.addthis.com/js/300/addthis_widget.js#pubid=ra-53f3772e07cb3cb1" async></script>
                                                                <script type="text/javascript">
                                                                                var addthis_config = {
                                                                                     pubid: "ra-545da5c700d7d99d"
                                                                                };
                                                                        var addthis_share =
                                                                                {
                                                                                   // ... members go here
                                                                                };
                                                                </script>

                                                        </div>
                                                        {/if}
                                                {/if}
                                        <!-- end pb-right-column-->

                                </form>
                        </div>
                        <div class="product-vendors col-sm-2">
                                <h5>Fabricantes</h5>
                                <p>_____</p>
                                {foreach from=$product->getManufacturers() item=manufacturer}
                                        <a href="{$return_link}?id_manufacturer={$manufacturer.id_manufacturer}">{$manufacturer.name}</a>
                                {/foreach}
                        </div>
                        <!-- end center infos-->
                </div>
        </div> <!-- end primary_block -->
        {if !$content_only}
                <div id="sns_tab_products" class="product-collateral clearfix">
                        <ul class="nav-tabs gfont">
                                {if $product->description}

                                <li class​="nav-item">
 <a class​="nav-link" data-toggle="tab" href="#ekomiprc">
 eKomi Reviews​ ({hook h='ekomiReviewsCount' mod=ekomiratingsandreviews
product=$product})
 </a>
</li>

                                        <li>
 <a href="#sns_tab_info" data-toggle="tab">{l s='More info'}</a></li>
                                {/if}

                                {if (isset($quantity_discounts) && count($quantity_discounts) > 0)}
                                        <li><a href="#sns_tab_discounts" data-toggle="tab">{l s='Volume discounts'}</a></li>
                                {/if}

                                {if isset($features) && $features}
                                        <li><a href="#sns_tab_datasheet" data-toggle="tab">{l s='Data sheet'}</a></li>
                                {/if}

                                {if isset($accessories) && $accessories}
                                        <li><a href="#sns_tab_accessories" data-toggle="tab">{l s='Accessories'}</a></li>
                                {/if}

                                {if (isset($product) && $product->description) || (isset($features) && $features) || (isset($accessories) && $accessories) || (isset($HOOK_PRODUCT_TAB) && $HOOK_PRODUCT_TAB) || (isset($attachments) && $attachments) || isset($product) && $product->customizable}
                                        {if isset($attachments) && $attachments}
                                                <li><a href="#sns_tab_attachements" data-toggle="tab">{l s='Download'}</a></li>
                                        {/if}

                                        {if isset($product) && $product->customizable}
                                                <li><a href="#sns_tab_customization" data-toggle="tab">{l s='Product customization'}</a></li>
                                        {/if}
                                {/if}
                                {$HOOK_PRODUCT_TAB}
                                {if $SNS_KTA_CUSTOMTAB}
                                        <li><a href="#sns_tab_custom" data-toggle="tab">{$SNS_KTA_CUSTOMTAB_TITLE}</a></li>
                                {/if}
                        </ul>
                        <div class="tab-content">

                            {block name='product_ekomiprc'}
 <div class​="tab-pane fade in" id="ekomiprc">
 {hook h='ekomiReviewsContainer' mod=ekomiratingsandreviews product=$product}
 </div>
{/block}


                                {if $product->description}
                                        <!-- More info -->
                                        <section id="sns_tab_info" class="page-product-box tab-pane fade">
                                                <div id="IcecatLive">{$product->description}</div>
                                        </section>
                                        <!--end  More info -->
                                {/if}

                                {if (isset($quantity_discounts) && count($quantity_discounts) > 0)}
                                        <!-- quantity discount -->
                                        <section id="sns_tab_discounts" class="page-product-box tab-pane fade">
                                                <div id="quantityDiscount">
                                                        <table class="std table-product-discounts">
                                                                <thead>
                                                                        <tr>
                                                                                <th>{l s='Quantity'}</th>
                                                                                <th>{if $display_discount_price}{l s='Price'}{else}{l s='Discount'}{/if}</th>
                                                                                <th>{l s='You Save'}</th>
                                                                        </tr>
                                                                </thead>
                                                                <tbody>
                                                                        {foreach from=$quantity_discounts item='quantity_discount' name='quantity_discounts'}
                                                                                <tr id="quantityDiscount_{$quantity_discount.id_product_attribute}" class="quantityDiscount_{$quantity_discount.id_product_attribute}" data-discount-type="{$quantity_discount.reduction_type}" data-discount="{$quantity_discount.real_value|floatval}" data-discount-quantity="{$quantity_discount.quantity|intval}">
                                                                                        <td>
                                                                                                {$quantity_discount.quantity|intval}
                                                                                        </td>
                                                                                        <td>
                                                                                                {if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
                                                                                                        {if $display_discount_price}
                                                                                                                {convertPrice price=$productPrice-$quantity_discount.real_value|floatval}
                                                                                                        {else}
                                                                                                                {convertPrice price=$quantity_discount.real_value|floatval}
                                                                                                        {/if}
                                                                                                {else}
                                                                                                        {if $display_discount_price}
                                                                                                                {convertPrice price = $productPrice-($productPrice*$quantity_discount.reduction)|floatval}
                                                                                                        {else}
                                                                                                                {$quantity_discount.real_value|floatval}%
                                                                                                        {/if}
                                                                                                {/if}
                                                                                        </td>
                                                                                        <td>
                                                                                                <span>{l s='Up to'}</span>
                                                                                                {if $quantity_discount.price >= 0 || $quantity_discount.reduction_type == 'amount'}
                                                                                                        {$discountPrice=$productPrice-$quantity_discount.real_value|floatval}
                                                                                                {else}
                                                                                                        {$discountPrice=$productPrice-($productPrice*$quantity_discount.reduction)|floatval}
                                                                                                {/if}
                                                                                                {$discountPrice=$discountPrice*$quantity_discount.quantity}
                                                                                                {$qtyProductPrice = $productPrice*$quantity_discount.quantity}
                                                                                                {convertPrice price=$qtyProductPrice-$discountPrice}
                                                                                        </td>
                                                                                </tr>
                                                                        {/foreach}
                                                                </tbody>
                                                        </table>
                                                </div>
                                        </section>
                                {/if}

                                {if isset($features) && $features}
                                        <!-- Data sheet -->
                                        <section id="sns_tab_datasheet" class="page-product-box tab-pane fade">
                                                <table class="table-data-sheet">
                                                        {foreach from=$features item=feature}
                                                        <tr class="{cycle values="odd,even"}">
                                                                {if isset($feature.value)}
                                                                <td>{$feature.name|escape:'html':'UTF-8'}</td>
                                                                <td>{$feature.value|escape:'html':'UTF-8'}</td>
                                                                {/if}
                                                        </tr>
                                                        {/foreach}
                                                </table>
                                        </section>
                                        <!--end Data sheet -->
                                {/if}

                                {if isset($accessories) && $accessories}
                                        <!--Accessories -->
                                        <section id="sns_tab_accessories" class="page-product-box tab-pane fade">
                                                <ul class="clearfix">
                                                        {foreach from=$accessories item=accessory name=accessories_list}
                                                                {if ($accessory.allow_oosp || $accessory.quantity_all_versions > 0 || $accessory.quantity > 0) && $accessory.available_for_order && !isset($restricted_country_mode)}
                                                                        {assign var='accessoryLink' value=$link->getProductLink($accessory.id_product, $accessory.link_rewrite, $accessory.category)}
                                                                        <li class="item product-box ajax_block_product{if $smarty.foreach.accessories_list.first} first_item{elseif $smarty.foreach.accessories_list.last} last_item{else} item{/if} product_accessories_description">
                                                                                <div class="product_desc">
                                                                                        <a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{$accessory.legend|escape:'html':'UTF-8'}" class="product-image product_image">
                                                                                                <img class="lazyOwl" src="{$link->getImageLink($accessory.link_rewrite, $accessory.id_image, 'home_default')|escape:'html':'UTF-8'}" alt="{$accessory.legend|escape:'html':'UTF-8'}" width="{$homeSize.width}" height="{$homeSize.height}"/>
                                                                                        </a>
                                                                                        <div class="block_description">
                                                                                                <a href="{$accessoryLink|escape:'html':'UTF-8'}" title="{l s='More'}" class="product_description">
                                                                                                        {$accessory.description_short|strip_tags|truncate:25:'...'}
                                                                                                </a>
                                                                                        </div>
                                                                                </div>
                                                                                <div class="s_title_block">
                                                                                        <h5 class="product-name">
                                                                                                <a href="{$accessoryLink|escape:'html':'UTF-8'}">
                                                                                                        {$accessory.name|truncate:20:'...':true|escape:'html':'UTF-8'}
                                                                                                </a>
                                                                                        </h5>
                                                                                        {if $accessory.show_price && !isset($restricted_country_mode) && !$PS_CATALOG_MODE}
                                                                                        <span class="price">
                                                                                                {if $priceDisplay != 1}
                                                                                                {displayWtPrice p=$accessory.price}{else}{displayWtPrice p=$accessory.price_tax_exc}
                                                                                                {/if}
                                                                                        </span>
                                                                                        {/if}
                                                                                </div>
                                                                                <div class="clearfix" style="margin-top:5px">
                                                                                        {if !$PS_CATALOG_MODE && ($accessory.allow_oosp || $accessory.quantity > 0)}
                                                                                                <div class="no-print">
                                                                                                        <a class="exclusive button ajax_add_to_cart_button" href="{$link->getPageLink('cart', true, NULL, "qty=1&amp;id_product={$accessory.id_product|intval}&amp;token={$static_token}&amp;add")|escape:'html':'UTF-8'}" data-id-product="{$accessory.id_product|intval}" title="{l s='Add to cart'}">
                                                                                                                <span>{l s='Add to cart'}</span>
                                                                                                        </a>
                                                                                                </div>
                                                                                        {/if}
                                                                                </div>
                                                                        </li>
                                                                {/if}
                                                        {/foreach}
                                                </ul>
                                        </section>
                                        <!--end Accessories -->
                                {/if}

                                <!-- description & features -->
                                {if (isset($product) && $product->description) || (isset($features) && $features) || (isset($accessories) && $accessories) || (isset($HOOK_PRODUCT_TAB) && $HOOK_PRODUCT_TAB) || (isset($attachments) && $attachments) || isset($product) && $product->customizable}
                                        {if isset($attachments) && $attachments}
                                                <!--Download -->
                                                <section id="sns_tab_attachements" class="page-product-box tab-pane fade">
                                                        {foreach from=$attachments item=attachment name=attachements}
                                                                {if $smarty.foreach.attachements.iteration %3 == 1}<div class="row">{/if}
                                                                        <div class="col-lg-4">
                                                                                <h4><a href="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attachment.id_attachment}")|escape:'html':'UTF-8'}">{$attachment.name|escape:'html':'UTF-8'}</a></h4>
                                                                                <p class="text-muted">{$attachment.description|escape:'html':'UTF-8'}</p>
                                                                                <a class="btn btn-default btn-block" href="{$link->getPageLink('attachment', true, NULL, "id_attachment={$attachment.id_attachment}")|escape:'html':'UTF-8'}">
                                                                                        <i class="fa fa-download"></i>
                                                                                        {l s="Download"} ({Tools::formatBytes($attachment.file_size, 2)})
                                                                                </a>
                                                                        </div>
                                                                {if $smarty.foreach.attachements.iteration %3 == 0 || $smarty.foreach.attachements.last}</div>{/if}
                                                        {/foreach}
                                                </section>
                                                <!--end Download -->
                                        {/if}

                                        {if isset($product) && $product->customizable}
                                                <!--Customization -->
                                                <section id="sns_tab_customization" class="page-product-box tab-pane fade">
                                                        <!-- Customizable products -->
                                                        <form method="post" action="{$customizationFormTarget}" enctype="multipart/form-data" id="customizationForm" class="clearfix">
                                                                <p class="infoCustomizable">
                                                                        {l s='After saving your customized product, remember to add it to your cart.'}
                                                                        {if $product->uploadable_files}
                                                                        <br />
                                                                        {l s='Allowed file formats are: GIF, JPG, PNG'}{/if}
                                                                </p>
                                                                {if $product->uploadable_files|intval}
                                                                        <div class="customizableProductsFile">
                                                                                <h5 class="product-heading-h5">{l s='Pictures'}</h5>
                                                                                <ul id="uploadable_files" class="clearfix">
                                                                                        {counter start=0 assign='customizationField'}
                                                                                        {foreach from=$customizationFields item='field' name='customizationFields'}
                                                                                                {if $field.type == 0}
                                                                                                        <li class="customizationUploadLine{if $field.required} required{/if}">{assign var='key' value='pictures_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
                                                                                                                {if isset($pictures.$key)}
                                                                                                                        <div class="customizationUploadBrowse">
                                                                                                                                <img src="{$pic_dir}{$pictures.$key}_small" alt="" />
                                                                                                                                        <a href="{$link->getProductDeletePictureLink($product, $field.id_customization_field)|escape:'html':'UTF-8'}" title="{l s='Delete'}" >
                                                                                                                                                <img src="{$img_dir}icon/delete.gif" alt="{l s='Delete'}" class="customization_delete_icon" width="11" height="13" />
                                                                                                                                        </a>
                                                                                                                        </div>
                                                                                                                {/if}
                                                                                                                <div class="customizationUploadBrowse form-group">
                                                                                                                        <label class="customizationUploadBrowseDescription">
                                                                                                                                {if !empty($field.name)}
                                                                                                                                        {$field.name}
                                                                                                                                {else}
                                                                                                                                        {l s='Please select an image file from your computer'}
                                                                                                                                {/if}
                                                                                                                                {if $field.required}<sup>*</sup>{/if}
                                                                                                                        </label>
                                                                                                                        <input type="file" name="file{$field.id_customization_field}" id="img{$customizationField}" class="form-control customization_block_input {if isset($pictures.$key)}filled{/if}" />
                                                                                                                </div>
                                                                                                        </li>
                                                                                                        {counter}
                                                                                                {/if}
                                                                                        {/foreach}
                                                                                </ul>
                                                                        </div>
                                                                {/if}
                                                                {if $product->text_fields|intval}
                                                                        <div class="customizableProductsText">
                                                                                <ul id="text_fields">
                                                                                {counter start=0 assign='customizationField'}
                                                                                {foreach from=$customizationFields item='field' name='customizationFields'}
                                                                                        {if $field.type == 1}
                                                                                                <li class="customizationUploadLine{if $field.required} required{/if}">
                                                                                                        <label for ="textField{$customizationField}">
                                                                                                                {assign var='key' value='textFields_'|cat:$product->id|cat:'_'|cat:$field.id_customization_field}
                                                                                                                {if !empty($field.name)}
                                                                                                                        {$field.name}
                                                                                                                {/if}
                                                                                                                {if $field.required}<sup>*</sup>{/if}
                                                                                                        </label>
                                                                                                        <textarea name="textField{$field.id_customization_field}" class="form-control customization_block_input" id="textField{$customizationField}" rows="3" cols="20">{strip}
                                                                                                                {if isset($textFields.$key)}
                                                                                                                        {$textFields.$key|stripslashes}
                                                                                                                {/if}
                                                                                                        {/strip}</textarea>
                                                                                                </li>
                                                                                                {counter}
                                                                                        {/if}
                                                                                {/foreach}
                                                                                </ul>
                                                                        </div>
                                                                {/if}
                                                                <p id="customizedDatas">
                                                                        <input type="hidden" name="quantityBackup" id="quantityBackup" value="" />
                                                                        <input type="hidden" name="submitCustomizedDatas" value="1" />
                                                                        <button class="button btn btn-default button button-small" name="saveCustomization">
                                                                                <span>{l s='Save'}</span>
                                                                        </button>
                                                                        <span id="ajax-loader" class="unvisible">
                                                                                <img src="{$img_ps_dir}loader.gif" alt="loader" />
                                                                        </span>
                                                                </p>
                                                        </form>
                                                        <p class="clear required"><sup>*</sup> {l s='required fields'}</p>
                                                </section>
                                                <!--end Customization -->
                                        {/if}
                                {/if}

                                {if isset($HOOK_PRODUCT_TAB_CONTENT) && $HOOK_PRODUCT_TAB_CONTENT}{$HOOK_PRODUCT_TAB_CONTENT}{/if}
                                {if $SNS_KTA_CUSTOMTAB}
                                        <section id="sns_tab_custom" class="page-product-box tab-pane fade">{$SNS_KTA_CUSTOMTAB_CONTENT}</section>
                                {/if}
                        </div><!--end .tab-content -->
                </div><!--end #sns_tab_products -->

                </div>
{*              <div class="col-md-3">
                </div> *}
        </div>
                <div class="clearfix"></div>

                <script>
                jQuery(document).ready(function($){
                        $('#sns_tab_products .nav-tabs').find("li").first().addClass("active");
                        $('#sns_tab_products .tab-content').find(".tab-pane").first().addClass("active in");

                        $('#sns_tab_products .nav-tabs').tabdrop();
                });
                </script>
                {if isset($HOOK_PRODUCT_FOOTER) && $HOOK_PRODUCT_FOOTER}{$HOOK_PRODUCT_FOOTER}{/if}

                {if isset($packItems) && $packItems|@count > 0}
                        <section id="blockpack">
                                <h3 class="page-product-heading">{l s='Pack content'}</h3>
                                {include file="$tpl_dir./product-list.tpl" products=$packItems}
                        </section>
                {/if}
        {/if}
</div> <!-- itemscope product wrapper -->
{strip}
{if isset($smarty.get.ad) && $smarty.get.ad}
        {addJsDefL name=ad}{$base_dir|cat:$smarty.get.ad|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{if isset($smarty.get.adtoken) && $smarty.get.adtoken}
        {addJsDefL name=adtoken}{$smarty.get.adtoken|escape:'html':'UTF-8'}{/addJsDefL}
{/if}
{addJsDef allowBuyWhenOutOfStock=$allow_oosp|boolval}
{addJsDef availableNowValue=$product->available_now|escape:'quotes':'UTF-8'}
{addJsDef availableLaterValue=$product->available_later|escape:'quotes':'UTF-8'}
{addJsDef attribute_anchor_separator=$attribute_anchor_separator|escape:'quotes':'UTF-8'}
{addJsDef attributesCombinations=$attributesCombinations}
{addJsDef currencySign=$currencySign|html_entity_decode:2:"UTF-8"}
{addJsDef currencyRate=$currencyRate|floatval}
{addJsDef currencyFormat=$currencyFormat|intval}
{addJsDef currencyBlank=$currencyBlank|intval}
{addJsDef currentDate=$smarty.now|date_format:'%Y-%m-%d %H:%M:%S'}
{if isset($combinations) && $combinations}
        {addJsDef combinations=$combinations}
        {addJsDef combinationsFromController=$combinations}
        {addJsDef displayDiscountPrice=$display_discount_price}
        {addJsDefL name='upToTxt'}{l s='Up to' js=1}{/addJsDefL}
{/if}
{if isset($combinationImages) && $combinationImages}
        {addJsDef combinationImages=$combinationImages}
{/if}
{addJsDef customizationFields=$customizationFields}
{addJsDef default_eco_tax=$product->ecotax|floatval}
{addJsDef displayPrice=$priceDisplay|intval}
{addJsDef ecotaxTax_rate=$ecotaxTax_rate|floatval}
{addJsDef group_reduction=$group_reduction}
{if isset($cover.id_image_only)}
        {addJsDef idDefaultImage=$cover.id_image_only|intval}
{else}
        {addJsDef idDefaultImage=0}
{/if}
{addJsDef img_ps_dir=$img_ps_dir}
{addJsDef img_prod_dir=$img_prod_dir}
{addJsDef id_product=$product->id|intval}
{addJsDef jqZoomEnabled=$jqZoomEnabled|boolval}
{addJsDef maxQuantityToAllowDisplayOfLastQuantityMessage=$last_qties|intval}
{addJsDef minimalQuantity=$product->minimal_quantity|intval}
{addJsDef noTaxForThisProduct=$no_tax|boolval}
{addJsDef customerGroupWithoutTax=$customer_group_without_tax|boolval}
{addJsDef oosHookJsCodeFunctions=Array()}
{addJsDef productHasAttributes=isset($groups)|boolval}
{addJsDef productPriceTaxExcluded=($product->getPriceWithoutReduct(true)|default:'null' - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcluded=($product->base_price - $product->ecotax)|floatval}
{addJsDef productBasePriceTaxExcl=($product->base_price|floatval)}
{addJsDef productReference=$product->reference|escape:'html':'UTF-8'}
{addJsDef productAvailableForOrder=$product->available_for_order|boolval}
{addJsDef productPriceWithoutReduction=$productPriceWithoutReduction|floatval}
{addJsDef productPrice=$productPrice|floatval}
{addJsDef productUnitPriceRatio=$product->unit_price_ratio|floatval}
{addJsDef productShowPrice=(!$PS_CATALOG_MODE && $product->show_price)|boolval}
{addJsDef PS_CATALOG_MODE=$PS_CATALOG_MODE}
{if $product->specificPrice && $product->specificPrice|@count}
        {addJsDef product_specific_price=$product->specificPrice}
{else}
        {addJsDef product_specific_price=array()}
{/if}
{if $display_qties == 1 && $product->quantity}
        {addJsDef quantityAvailable=$product->quantity}
{else}
        {addJsDef quantityAvailable=0}
{/if}
{addJsDef quantitiesDisplayAllowed=$display_qties|boolval}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'percentage'}
        {addJsDef reduction_percent=$product->specificPrice.reduction*100|floatval}
{else}
        {addJsDef reduction_percent=0}
{/if}
{if $product->specificPrice && $product->specificPrice.reduction && $product->specificPrice.reduction_type == 'amount'}
        {addJsDef reduction_price=$product->specificPrice.reduction|floatval}
{else}
        {addJsDef reduction_price=0}
{/if}
{if $product->specificPrice && $product->specificPrice.price}
        {addJsDef specific_price=$product->specificPrice.price|floatval}
{else}
        {addJsDef specific_price=0}
{/if}
{addJsDef specific_currency=($product->specificPrice && $product->specificPrice.id_currency)|boolval} {* TODO: remove if always false *}
{addJsDef stock_management=$stock_management|intval}
{addJsDef taxRate=$tax_rate|floatval}
{addJsDefL name=doesntExist}{l s='This combination does not exist for this product. Please select another combination.' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMore}{l s='This product is no longer in stock' js=1}{/addJsDefL}
{addJsDefL name=doesntExistNoMoreBut}{l s='with those attributes but is available with others.' js=1}{/addJsDefL}
{addJsDefL name=fieldRequired}{l s='Please fill in all the required fields before saving your customization.' js=1}{/addJsDefL}
{addJsDefL name=uploading_in_progress}{l s='Uploading in progress, please be patient.' js=1}{/addJsDefL}
{addJsDefL name='product_fileDefaultHtml'}{l s='No file selected' js=1}{/addJsDefL}
{addJsDefL name='product_fileButtonHtml'}{l s='Choose File' js=1}{/addJsDefL}
{/strip}
{/if}
