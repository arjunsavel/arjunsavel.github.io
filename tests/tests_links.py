import os
import unittest
import webbrowser
import urllib
from urllib.request import urlopen
from bs4 import BeautifulSoup as bs
import codecs
import asyncio
import ssl
ssl._create_default_https_context = ssl._create_unverified_context


def get_links(page):
	"""Returns all the links within a given page."""
	with open(page, "r", encoding='utf-8') as f:
		text= f.read()
		soup = bs(text, "html.parser")
		links = []
		for a in soup.find_all('a', href=True):
			links.append(a['href'])
		f.close()
	return links

class TestLinks(unittest.TestCase):
	# start index.html

	def test_internal_html(self, page=None):
		"""start index.html"""
		global good_link
		if not page:
			links = get_links("index.html")
			good_link = True
		else:
			links = get_links(page)
		for link in links:
			if link[:4] != 'http' and link[-4:] == 'html': # if it's an internal link
				try:
					f=codecs.open(link, 'r')
					self.test_internal_html(page=link)
					f.close()
				except FileNotFoundError: # internal link doesn't exist doesn't exist
					good_link = False 
		asyncio.set_event_loop(asyncio.new_event_loop())

		self.assertTrue(good_link)


	def test_external_links(self, page=None):
		"""Needs the previous test to pass."""
		global good_link # it's recursive
		if not page:
			links = get_links("index.html")
			good_link = True
		else:
			links = get_links(page)
		for link in links:
			if link[:4] == 'http' and 'orcid' not in link: # if it's an external link that's not ORCID
				try:
					urlopen(link)
				except urllib.error.HTTPError: # website doesn't exist
					good_link = False 
			elif link[:4] != 'http' and link[:-4] == 'html': # if it's an internal link
				self.test_external_html(page=link)
		asyncio.set_event_loop(asyncio.new_event_loop())
		self.assertTrue(good_link)

	


