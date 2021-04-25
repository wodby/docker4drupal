{% extends "@bootstrap_barrio/layout/page.html.twig" %}

{#
/**
 * @file
 * Bootstrap Barrio's theme implementation to display a single page.
 *
 * The doctype, html, head and body tags are not in this template. Instead they
 * can be found in the html.html.twig template normally located in the
 * core/modules/system directory.
 *
 * Available variables:
 *
 * General utility variables:
 * - base_path: The base URL path of the Drupal installation. Will usually be
 *   "/" unless you have installed Drupal in a sub-directory.
 * - is_front: A flag indicating if the current page is the front page.
 * - logged_in: A flag indicating if the user is registered and signed in.
 * - is_admin: A flag indicating if the user has permission to access
 *   administration pages.
 *
 * Site identity:
 * - front_page: The URL of the front page. Use this instead of base_path when
 *   linking to the front page. This includes the language domain or prefix.
 * - logo: The url of the logo image, as defined in theme settings.
 * - site_name: The name of the site. This is empty when displaying the site
 *   name has been disabled in the theme settings.
 * - site_slogan: The slogan of the site. This is empty when displaying the site
 *   slogan has been disabled in theme settings.

 * Page content (in order of occurrence in the default page.html.twig):
 * - node: Fully loaded node, if there is an automatically-loaded node
 *   associated with the page and the node ID is the second argument in the
 *   page's path (e.g. node/12345 and node/12345/revisions, but not
 *   comment/reply/12345).
 *
 * Regions:
 * - page.top_header: Items for the top header region.
 * - page.top_header_form: Items for the top header form region.
 * - page.header: Items for the header region.
 * - page.header_form: Items for the header form region.
 * - page.highlighted: Items for the highlighted region.
 * - page.primary_menu: Items for the primary menu region.
 * - page.secondary_menu: Items for the secondary menu region.
 * - page.featured_top: Items for the featured top region.
 * - page.content: The main content of the current page.
 * - page.sidebar_first: Items for the first sidebar.
 * - page.sidebar_second: Items for the second sidebar.
 * - page.featured_bottom_first: Items for the first featured bottom region.
 * - page.featured_bottom_second: Items for the second featured bottom region.
 * - page.featured_bottom_third: Items for the third featured bottom region.
 * - page.footer_first: Items for the first footer column.
 * - page.footer_second: Items for the second footer column.
 * - page.footer_third: Items for the third footer column.
 * - page.footer_fourth: Items for the fourth footer column.
 * - page.footer_fifth: Items for the fifth footer column.
 * - page.breadcrumb: Items for the breadcrumb region.
 *
 * Theme variables:
 * - navbar_top_attributes: Items for the header region.
 * - navbar_attributes: Items for the header region.
 * - content_attributes: Items for the header region.
 * - sidebar_first_attributes: Items for the highlighted region.
 * - sidebar_second_attributes: Items for the primary menu region.
 *
 * @see template_preprocess_page()
 * @see bootstrap_barrio_preprocess_page()
 * @see html.html.twig
 */
#}

{% block head %}
        {% if page.secondary_menu or page.top_header or page.top_header_form %}
          <nav{{ navbar_top_attributes }}>
          {% if container_navbar %}
          <div class="container">
          {% endif %}
              {{ page.secondary_menu }}
              {{ page.top_header }}
              {% if page.top_header_form %}
                <div class="form-inline navbar-form float-right">
                  {{ page.top_header_form }}
                </div>
              {% endif %}
          {% if container_navbar %}
          </div>
          {% endif %}
          </nav>
        {% endif %}
        <nav{{ navbar_attributes }}>
          {% if container_navbar %}
          <div class="container">
          {% endif %}
            {{ page.header }}
            {% if page.primary_menu or page.header_form %}
              <button class="navbar-toggler navbar-toggler-right" type="button" data-toggle="collapse" data-target="#CollapsingNavbar" aria-controls="CollapsingNavbar" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
              <div class="collapse navbar-collapse" id="CollapsingNavbar">
                {{ page.primary_menu }}
                {% if page.header_form %}
                  <div class="form-inline navbar-form float-right">
                    {{ page.header_form }}
                  </div>
                {% endif %}
	          </div>
            {% endif %}
            {% if sidebar_collapse %}
              <button class="navbar-toggler navbar-toggler-left collapsed" type="button" data-toggle="collapse" data-target="#CollapsingLeft" aria-controls="CollapsingLeft" aria-expanded="false" aria-label="Toggle navigation"></button>
            {% endif %}
          {% if container_navbar %}
          </div>
          {% endif %}
        </nav>
{% endblock %}

{% block content %}
        <div id="main" class="{{ container }}">
          {{ page.breadcrumb }}
          <div class="row row-offcanvas row-offcanvas-left clearfix">
              <main{{ content_attributes }}>
                <section class="section">
                  <a id="main-content" tabindex="-1"></a>
                  {{ page.content }}
                </section>
              </main>
            {% if page.sidebar_first %}
              <div{{ sidebar_first_attributes }}>
                <aside class="section" role="complementary">
                  {{ page.sidebar_first }}
                </aside>
              </div>
            {% endif %}
            {% if page.sidebar_second %}
              <div{{ sidebar_second_attributes }}>
                <aside class="section" role="complementary">
                  {{ page.sidebar_second }}
                </aside>
              </div>
            {% endif %}
          </div>
        </div>
{% endblock %}

{% block footer %}
        <div class="{{ container }}">
          {% if page.footer_first or page.footer_second or page.footer_third or page.footer_fourth %}
            <div class="site-footer__top clearfix">
              {{ page.footer_first }}
              {{ page.footer_second }}
              {{ page.footer_third }}
              {{ page.footer_fourth }}
            </div>
          {% endif %}
          {% if page.footer_fifth %}
            <div class="site-footer__bottom">
              {{ page.footer_fifth }}
            </div>
          {% endif %}
        </div>
{% endblock %}
