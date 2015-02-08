# coding: utf-8
from bs4 import BeautifulSoup
from os.path import isfile
from collections import defaultdict

import codecs
import requests
import json
import logging
import sys

root = logging.getLogger()
root.setLevel(logging.DEBUG)

ch = logging.StreamHandler(sys.stdout)
ch.setLevel(logging.DEBUG)
formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(message)s')
ch.setFormatter(formatter)
root.addHandler(ch)

if isfile('episodes.dump'):
    logging.info("Loading dump")
    with open('episodes.dump') as f:
        soup = BeautifulSoup(f.read())
else:
    logging.info("Dump not present fetching from wikipedia")
    requests.get('http://en.wikipedia.org/wiki/List_of_The_Office_%28U.S._TV_series%29_episodes')
    page = requests.get('http://en.wikipedia.org/wiki/List_of_The_Office_%28U.S._TV_series%29_episodes')
    with codecs.open('episodes.dump', 'w', encoding='utf-8') as f:
        f.write(page.text)
    soup = BeautifulSoup(page.text)

tables = soup.findAll("table", { "class" : "wikitable plainrowheaders" })

results = {}
season = 1
ep = 1
for tab in tables:
    for row in tab.findAll("tr"):
        cells = row.findAll("td")
        episode = [cell.findAll(text=True) for cell in cells]
        if len(episode) == 7:
            results[ep] = ['season-'+str(season)] + episode
            ep += 1
    season += 1


clean_by_episodes = {}
clean_by_writers = defaultdict(list)
for ep, dets in results.iteritems():
    # 165 [u'season-9', [u'2'], [u'"', u"Roy's Wedding", u'"'], [u'Matt Sohn'],
    # [u'Allison Silverman'], [u'September\xa027,\xa02012', u'\xa0(',
    # u'2012-09-27', u')'], [u'9002'], [u'4.13', u'[', u'204', u']']]
    clean_by_episodes[ep] = {'season': dets[0],
                             'title': dets[2][1],
                             'director': dets[3][0],
                             'writers': dets[4][0].split('&')}
    for writer in clean_by_episodes[ep]['writers']:
        clean_by_writers[writer].append(clean_by_episodes[ep]['director'])

combined = {'episodes': clean_by_episodes, 'writers': clean_by_writers}

with open('theoffice.json', 'w') as f:
    json.dump(combined, f)
